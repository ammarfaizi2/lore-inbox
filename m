Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129455AbRAAKVa>; Mon, 1 Jan 2001 05:21:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130580AbRAAKVU>; Mon, 1 Jan 2001 05:21:20 -0500
Received: from [213.167.220.121] ([213.167.220.121]:36359 "EHLO
	penny.ik5pvx.ampr.org") by vger.kernel.org with ESMTP
	id <S129455AbRAAKVG>; Mon, 1 Jan 2001 05:21:06 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-prerelease compile error in (maybe) mkiss
In-Reply-To: <Pine.LNX.4.30.0101010911590.769-100000@prime.sun.ac.za>
Reply-To: Pierfrancesco Caci <p.caci@tin.it>
From: Pierfrancesco Caci <ik5pvx@penny.ik5pvx.ampr.org>
Date: 01 Jan 2001 10:50:29 +0100
In-Reply-To: Hans Grobler's message of "Mon, 1 Jan 2001 10:04:46 +0200 (SAST)"
Message-ID: <873df3lhy2.fsf@penny.ik5pvx.ampr.org>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

:-> "Hans" == Hans Grobler <grobh@sun.ac.za> writes:



    > diff -u4Nr -X dontdiff linux-2.4.0-prerelease.orig/drivers/net/setup.c linux-2.4.0-prerelease/drivers/net/setup.c
    > --- linux-2.4.0-prerelease.orig/drivers/net/setup.c	Mon Dec 11 21:38:29 2000
    > +++ linux-2.4.0-prerelease/drivers/net/setup.c	Mon Jan  1 07:21:15 2001
[...]


your patchlet helped compiling cleanly. Still have to see if it
actually works (I have a couple of apt-get running, must
wait till they finish...)

Pf




-- 

-------------------------------------------------------------------------------
 Pierfrancesco Caci | ik5pvx | mailto:p.caci@tin.it  -  http://gusp.dyndns.org
  Firenze - Italia  | Office for the Complication of Otherwise Simple Affairs 
     Linux penny 2.4.0-test10 #1 Wed Nov 8 22:58:01 CET 2000 i686 unknown
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
