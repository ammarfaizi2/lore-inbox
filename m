Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266044AbSKFTVc>; Wed, 6 Nov 2002 14:21:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266054AbSKFTVc>; Wed, 6 Nov 2002 14:21:32 -0500
Received: from ip68-105-128-224.tc.ph.cox.net ([68.105.128.224]:25274 "EHLO
	Bill-The-Cat.bloom.county") by vger.kernel.org with ESMTP
	id <S266044AbSKFTVb>; Wed, 6 Nov 2002 14:21:31 -0500
Date: Wed, 6 Nov 2002 12:28:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: xmb <xmb@kick.sytes.net>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: initramfs in 2.5.46 wont compile
Message-ID: <20021106192804.GA5490@opus.bloom.county>
References: <2147483647.1036601487@[192.168.1.2]> <3DC93C34.40201@pobox.com> <2147483647.1036602241@[192.168.1.2]> <3DC940A6.4010506@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DC940A6.4010506@pobox.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 06, 2002 at 11:17:42AM -0500, Jeff Garzik wrote:
> xmb wrote:
> >-- Jeff Garzik <jgarzik@pobox.com> wrote:
> >
> >>ppc arch support for initramfs needs to be added...
> >
> >
> >oh... is there a way to disable the initramfs build in a safe way so i 
> >can continue compiling the kernel without it
> 
> Nope, just hunt around the ppc mailing lists for a patch... I'm sure one 
> will appear very soon, if it hasn't already been created.

Or better yet, use the ppc 2.5 tree.  Check out
http://penguinppc.org/dev/kernel.shtml, and get the linuxppc-2.5 tree
(based on the linux-2.5 one, so you can just pull into a clone of that
if you already have one).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
