Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131797AbQJ2PJp>; Sun, 29 Oct 2000 10:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131799AbQJ2PJf>; Sun, 29 Oct 2000 10:09:35 -0500
Received: from mailgate2.zdv.Uni-Mainz.DE ([134.93.8.57]:16312 "EHLO
	mailgate2.zdv.Uni-Mainz.DE") by vger.kernel.org with ESMTP
	id <S131797AbQJ2PJU>; Sun, 29 Oct 2000 10:09:20 -0500
Date: Sun, 29 Oct 2000 16:09:16 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Richard Henderson <rth@twiddle.net>
Cc: Keith Owens <kaos@ocs.com.au>, Pavel Machek <pavel@suse.cz>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: [patch] kernel/module.c (plus gratuitous rant)
Message-ID: <20001029160916.B12250@uni-mainz.de>
Mail-Followup-To: Richard Henderson <rth@twiddle.net>,
	Keith Owens <kaos@ocs.com.au>, Pavel Machek <pavel@suse.cz>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20001027194513.A1060@bug.ucw.cz> <4309.972694843@ocs3.ocs-net> <20001028131558.A17429@uni-mainz.de> <20001028172700.A13608@twiddle.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
User-Agent: Mutt/1.0.1i
In-Reply-To: <20001028172700.A13608@twiddle.net>; from rth@twiddle.net on Sat, Oct 28, 2000 at 05:27:00PM -0700
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 28, 2000 at 05:27:00PM -0700, Richard Henderson wrote:
> On Sat, Oct 28, 2000 at 01:15:58PM +0200, Dominik Kubla wrote:
> > Even simpler: "gcc -V 2.7.2.3" or "gcc -V 2.95.2" or whatever...
> 
> Which was a nice idea, but it doesn't actually work.  Changes
> in spec file format between versions makes this fall over.

Wow. So much for reading the manual... well, that's considered 
cheating anyway, isn't it?

Dominik
-- 
http://petition.eurolinux.org/index_html - No Software Patents In Europe!
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
