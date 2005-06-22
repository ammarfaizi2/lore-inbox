Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261454AbVFVP1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261454AbVFVP1x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Jun 2005 11:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbVFVP1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Jun 2005 11:27:53 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:23179 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261454AbVFVPI6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Jun 2005 11:08:58 -0400
Date: Wed, 22 Jun 2005 17:08:39 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Miklos Szeredi <miklos@szeredi.hu>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: -mm -> 2.6.13 merge status (fuse)
Message-ID: <20050622150839.GB1881@elf.ucw.cz>
References: <20050620235458.5b437274.akpm@osdl.org> <E1Dkfu2-0005Ju-00@dorka.pomaz.szeredi.hu> <20050621142820.GC2015@openzaurus.ucw.cz> <E1DkkRE-0005mt-00@dorka.pomaz.szeredi.hu> <20050621220619.GC2815@elf.ucw.cz> <a4e6962a05062207435dd16240@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4e6962a05062207435dd16240@mail.gmail.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > > An emotional argument again.  What's "strange" about it?
> > 
> > Not so emotional argument...
> > 
> > System where users can mount their own filesystems should not be
> > called "Unix" any more. It introduces new mechanism, similar to
> > ptrace.
> 
> I think that's a rather severe statement.   I don't see allowing user
> mounts damaging standard UNIX system semantics as long as certain
> rules are followed.   After all, user-mounts and private name spaces
> are what the original authors of UNIX went on to develop.

Well, but notice how it is called "Plan 9", not "Unix" :-). The
"certain rules" are rather tricky to enforce... btw any ideas how
Plan 9 solves problems around user-mounts? Does it allow it at all?

								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
