Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130443AbRAGLRO>; Sun, 7 Jan 2001 06:17:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130484AbRAGLRE>; Sun, 7 Jan 2001 06:17:04 -0500
Received: from yoda.planetinternet.be ([195.95.30.146]:29963 "EHLO
	yoda.planetinternet.be") by vger.kernel.org with ESMTP
	id <S130443AbRAGLQy>; Sun, 7 Jan 2001 06:16:54 -0500
Date: Sun, 7 Jan 2001 12:16:33 +0100
From: Kurt Roeckx <Q@ping.be>
To: Brett <bpemberton@dingoblue.net.au>
Cc: Matthias Juchem <juchem@uni-mannheim.de>,
        Ulrich Drepper <drepper@cygnus.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] new bug report script
Message-ID: <20010107121633.A6815@ping.be>
In-Reply-To: <Pine.LNX.4.30.0101070858400.7104-100000@gandalf.math.uni-mannheim.de> <Pine.LNX.4.21.0101072041380.12767-100000@tae-bo.generica.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre2i
In-Reply-To: <Pine.LNX.4.21.0101072041380.12767-100000@tae-bo.generica.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 07, 2001 at 08:43:12PM +1100, Brett wrote:
> 
> Taking a guess here....
> 
> strings /lib/libc* | grep "release version"
> 
> I'm not sure how reliable this method is either :)

That returns nothing here.

I do find this in it:
"@(#) The Linux C library 5.4.46"


Kurt

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
