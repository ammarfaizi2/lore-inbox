Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281779AbRLKQ3S>; Tue, 11 Dec 2001 11:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281823AbRLKQ3I>; Tue, 11 Dec 2001 11:29:08 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:48345 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S281779AbRLKQ26>; Tue, 11 Dec 2001 11:28:58 -0500
Subject: Re: Scsi problems in 2.5.1-pre9
From: Paul Larson <plars@austin.ibm.com>
To: Jens Axboe <axboe@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20011211161959.GA13498@suse.de>
In-Reply-To: <1008065277.25964.5.camel@plars.austin.ibm.com>
	<20011211160543.GZ13498@suse.de>  <20011211161959.GA13498@suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.14 (Preview Release)
Date: 11 Dec 2001 10:34:27 +0000
Message-Id: <1008066868.25964.8.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-12-11 at 16:19, Jens Axboe wrote:

> It seems to affect all SCSI drivers with CLUSTERING enabled. Don't worry
> about data consistency btw, the above is a warning only (the right
> segment count is used).
So... this isn't a problem that my machine was locked up, I couldn't log
in, or break out of the hung process, and it came back in an
inconsistant state?

