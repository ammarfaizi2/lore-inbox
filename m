Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267972AbTCFJuh>; Thu, 6 Mar 2003 04:50:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267970AbTCFJud>; Thu, 6 Mar 2003 04:50:33 -0500
Received: from modemcable092.130-200-24.mtl.mc.videotron.ca ([24.200.130.92]:7249
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S267972AbTCFJu1>; Thu, 6 Mar 2003 04:50:27 -0500
Date: Thu, 6 Mar 2003 04:58:47 -0500 (EST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: Mike Anderson <andmike@us.ibm.com>
cc: Andries.Brouwer@cwi.nl, "" <torvalds@transmeta.com>,
       "" <linux-kernel@vger.kernel.org>, "" <linux-scsi@vger.kernel.org>
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
In-Reply-To: <20030306091824.GA2577@beaverton.ibm.com>
Message-ID: <Pine.LNX.4.50.0303060455560.25282-100000@montezuma.mastecende.com>
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl>
 <20030306064921.GA1425@beaverton.ibm.com>
 <Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com>
 <20030306083054.GB1503@beaverton.ibm.com>
 <Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com>
 <20030306085506.GB2222@beaverton.ibm.com>
 <Pine.LNX.4.50.0303060354550.25282-100000@montezuma.mastecende.com>
 <20030306091824.GA2577@beaverton.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Mar 2003, Mike Anderson wrote:

> Would it be possible for you to send me a console output with
> scsi_logging=1 so that I can narrow down the failure case.

The following is from 2.5.63-mjb2

http://function.linuxpower.ca/patches/numaq/dmesg-scsi_logging

The [disconnect] point is where it locks up

	Zwane
-- 
function.linuxpower.ca
