Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263048AbTCSOMt>; Wed, 19 Mar 2003 09:12:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263049AbTCSOMt>; Wed, 19 Mar 2003 09:12:49 -0500
Received: from [195.39.17.254] ([195.39.17.254]:7684 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S263048AbTCSOMs>;
	Wed, 19 Mar 2003 09:12:48 -0500
Date: Mon, 17 Mar 2003 11:38:18 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Shaya Potter <spotter@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fork/sh/hello microbenchmark performance in chroot
Message-ID: <20030317103818.GA9964@zaurus.ucw.cz>
References: <1047606184.10046.9.camel@zaphod> <1047606869.7428.12.camel@zaphod> <1047607433.7428.23.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1047607433.7428.23.camel@zaphod>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> when I run it /chroot/tmp/benchmark/forksh, I get .2s
> 
> but when I chroot into the /chroot tree and run /tmp/benchmark/forksh I
> get 1s.

And if you force forksh to use libc from
chroot?
-- 
				Pavel
Written on sharp zaurus, because my Velo1 broke. If you have Velo you don't need...

