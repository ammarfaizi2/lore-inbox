Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315454AbSEYXnU>; Sat, 25 May 2002 19:43:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315459AbSEYXk6>; Sat, 25 May 2002 19:40:58 -0400
Received: from bs1.dnx.de ([213.252.143.130]:61610 "EHLO bs1.dnx.de")
	by vger.kernel.org with ESMTP id <S315452AbSEYXju>;
	Sat, 25 May 2002 19:39:50 -0400
Date: Sun, 26 May 2002 01:27:41 +0200
From: Robert Schwebel <robert@schwebel.de>
To: Mark Mielke <mark@mark.mielke.cc>
Cc: linux-kernel@vger.kernel.org
Subject: Re: patent on O_ATOMICLOOKUP [Re: [PATCH] loopable tmpfs (2.4.17)]
Message-ID: <20020526012741.D598@schwebel.de>
In-Reply-To: <Pine.LNX.4.44.0205251057370.6515-100000@home.transmeta.com> <3CEFD65A.ED871095@opersys.com> <20020525143358.A4481@mark.mielke.cc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.16i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 25, 2002 at 02:33:58PM -0400, Mark Mielke wrote:
> From what I understand, Linux _is_ being considered for RT applications
> by quite a few heavy-weights in the field including IBM, Intel and quite
> a few others. 

Uhm, that shows that you don't have _any_ idea what's going on in the
automation field. IBM is an IT company, and Intel is a processor
manufacturer. We are talking about the world of signal processors and PLCs
here, where companies like Siemens, ABB, Schneider etc. are the big
players. 

> My limited observations suggest that the primary reasons people do not
> use Linux for their RT applications are:
> 
>     1) They don't trust it for 'high availability'.

Not correct. 

>     2) They already have their application mostly written, or
>        completely written, for some other RT operating system, and
>        it would cost too much to switch.

You would be wondering how fast you can port an application for another
RTOS to RTAI. There is even a module for RTAI/LXRT which lets you run
Matlab/RTW code natively on RTAI...

Robert
-- 
 +--------------------------------------------------------+
 | Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de |
 | Pengutronix - Linux Solutions for Science and Industry |
 |   Braunschweiger Str. 79,  31134 Hildesheim, Germany   |
 |    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4    |
 +--------------------------------------------------------+
