Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751006AbVKVFPF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751006AbVKVFPF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 00:15:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932253AbVKVFPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 00:15:04 -0500
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:45714
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S1751006AbVKVFPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 00:15:01 -0500
From: Rob Landley <rob@landley.net>
Organization: Boundaries Unlimited
To: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH] make miniconfig (take 2)
Date: Mon, 21 Nov 2005 23:14:39 -0600
User-Agent: KMail/1.8
Cc: Roman Zippel <zippel@linux-m68k.org>, linux-kernel@vger.kernel.org,
       Sam Ravnborg <sam@ravnborg.org>
References: <200511170629.42389.rob@landley.net> <200511211253.40212.rob@landley.net> <20051121192431.GJ29518@elf.ucw.cz>
In-Reply-To: <20051121192431.GJ29518@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511212314.41605.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 21 November 2005 13:24, Pavel Machek wrote:
> Hi!
> > I'm hoping to get an ack from the kconfig guys first, hence the cc:
> >
> > But does it work ok for you?
>
> I was not even able to patch it properly :-(. Version against current
> -git would be handy.

Ouch.  It applied cleanly against both -rc1 and -rc2.  Ok, um...

Is there any way to extract a current patch against 2.6.15-rc1-git1 from the 
git web page?  I can get the most _recent_ diff at: 
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git

But that's just for one changeset.  Possibly I can iterate through the 
changesets to get all the diffs back to -git1 and apply them in sequence (if 
that works).  But the ability to right click and download one big rollup 
patch would be really really nice.

Rob

P.S.  I don't use git.  Poked at it a few times, but I made the mistake of 
reading largeish chunks of the git man page and the git glossary in an 
attempt to get up to speed, and got a headache.  Anything that can define 
"clean" in such a way that I'm _less_ sure of the definition afterwards:
http://www.kernel.org/pub/software/scm/git/docs/glossary.html
Learning git went back on the to-do list somewhere between cleaning behind the 
refrigerator and sorting my book collection by author...
