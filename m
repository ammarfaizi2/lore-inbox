Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274738AbRIZAFx>; Tue, 25 Sep 2001 20:05:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274739AbRIZAFm>; Tue, 25 Sep 2001 20:05:42 -0400
Received: from [195.223.140.107] ([195.223.140.107]:16113 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S274738AbRIZAFj>;
	Tue, 25 Sep 2001 20:05:39 -0400
Date: Wed, 26 Sep 2001 02:06:17 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Michael Rothwell <rothwell@holly-springs.nc.us>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.10 much better than previous 2.4.x :-)
Message-ID: <20010926020617.T1782@athlon.random>
In-Reply-To: <1001377785.1430.7.camel@gromit.house>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1001377785.1430.7.camel@gromit.house>; from rothwell@holly-springs.nc.us on Mon, Sep 24, 2001 at 08:29:44PM -0400
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 24, 2001 at 08:29:44PM -0400, Michael Rothwell wrote:
> 
> This is mainly a thank you for 2.4.10. It performs much better than
> 2.4.7 (RedHat version), from which I upgraded. Interactive performance
> for applications (Gnome, Evolution, Mozilla) is much improved, and my
> swap load is at zero, which is probably where it should be (2.4.7 would
> regularly be using 256MB of swap with the same applications running).

if you apply vm-tweaks-1 it should get even better ;).

Andrea
