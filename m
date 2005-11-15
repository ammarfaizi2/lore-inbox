Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965041AbVKOWQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965041AbVKOWQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932195AbVKOWQ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:16:57 -0500
Received: from mail.kroah.org ([69.55.234.183]:12191 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932155AbVKOWQ5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:16:57 -0500
Date: Tue, 15 Nov 2005 14:01:36 -0800
From: Greg KH <gregkh@suse.de>
To: Jesper Juhl <jesper.juhl@gmail.com>
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Message-ID: <20051115220136.GA12413@suse.de>
References: <20051115210459.GA11363@kroah.com> <9a8748490511151406y72e82354w5c5599ea6201d38e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9a8748490511151406y72e82354w5c5599ea6201d38e@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 11:06:04PM +0100, Jesper Juhl wrote:
> On 11/15/05, Greg KH <gregkh@suse.de> wrote:
> > Here's an updated version of the "HOTO do Linux kernel development"
> > document that I've been working on.
> >
> > For a description of why I started this, please see:
> >         http://thread.gmane.org/gmane.linux.kernel/348689
> >
> > I've addressed all of the comments that I have received, and flushed out
> > the the TODO sections.  I'd appreciate any comments on this version, as
> > I think it's looking pretty good and finished for now.  If no one
> > objects, I'll send it in a patch for inclusion in the main tree soon.
> >
> [snip]
> >
> >   Documentation/applying-patches.txt
> >     A good introduction describing exactly what a patch is, how to
> >     create it, and how to apply it to the different development branches
> >     of the kernel.
> >
> [snip]
> 
> I don't believe I mention anything about patch /creation/ in
> applying-patches.txt, at least the point of the document when I wrote
> it was to explain what a patch is, how to apply it and give a short
> description of the various trees.
> So, your description is accurate except for the "how to create it" bit.

Ah, you are right.  I was thinking of the SubmittingPatches file, that
is where we describe how to create a patch.

thanks for catching this, I've fixed it up.

greg k-h
