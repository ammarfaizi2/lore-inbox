Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267835AbTCFImv>; Thu, 6 Mar 2003 03:42:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267368AbTCFImv>; Thu, 6 Mar 2003 03:42:51 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:56505 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S267026AbTCFImu>; Thu, 6 Mar 2003 03:42:50 -0500
Date: Thu, 6 Mar 2003 00:55:06 -0800
From: Mike Anderson <andmike@us.ibm.com>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
Cc: Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: 2.5.63/64 do not boot: loop in scsi_error
Message-ID: <20030306085506.GB2222@beaverton.ibm.com>
Mail-Followup-To: Zwane Mwaikambo <zwane@linuxpower.ca>,
	Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
References: <UTC200303060639.h266dIo22884.aeb@smtp.cwi.nl> <20030306064921.GA1425@beaverton.ibm.com> <Pine.LNX.4.50.0303060256200.25282-100000@montezuma.mastecende.com> <20030306083054.GB1503@beaverton.ibm.com> <Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.50.0303060331030.25282-100000@montezuma.mastecende.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux 2.0.32 on an i486
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo [zwane@linuxpower.ca] wrote:
> I'm not concerned about that, that was peripheral damage from another 
> patch (affected irq handling), the difference being is that with 2.5.62 it boots 
> after printing those errors a couple of times, but with 2.5.63 it doesn't.

Ok I will keep looking at this , I believe I have a PLEXTOR CD in the
lab I will add this to my qlogic isp bus and see if I can get the error
to show up. I am running cd drives on the other adapters and I am not
seeing a problem. 

-andmike
--
Michael Anderson
andmike@us.ibm.com

