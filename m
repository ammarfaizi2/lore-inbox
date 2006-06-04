Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932100AbWFDKAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932100AbWFDKAL (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 06:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751433AbWFDKAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 06:00:10 -0400
Received: from wr-out-0506.google.com ([64.233.184.225]:9104 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751390AbWFDKAJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 06:00:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PDG9FhtslAEjTj+2ZAFG4hwq/f4QCu73u2uCaaTC2YYJAD61LQdu/JYFB8hjmbzISGg/LL3aWnHh6D9MNnVhuf5FR0DjHno9dJbq5WoJ2Jz2thi124CIYQR2eTAsu/Fb+4bdDfOIc4pr9LbgzXLeslag1VNAcPgFU/ueMIUQKCA=
Message-ID: <4d8e3fd30606040300w6d939f4csfe96829d3e5481a9@mail.gmail.com>
Date: Sun, 4 Jun 2006 12:00:08 +0200
From: "Paolo Ciarrocchi" <paolo.ciarrocchi@gmail.com>
To: "Horst von Brand" <vonbrand@inf.utfsm.cl>
Subject: Re: Linux kernel development
Cc: linux-kernel@vger.kernel.org, "Kalin KOZHUHAROV" <kalin@thinrope.net>,
        "Jesper Juhl" <jesper.juhl@gmail.com>, "Greg KH" <greg@kroah.com>
In-Reply-To: <200606031828.k53ISSgr012167@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <paolo.ciarrocchi@gmail.com>
	 <4d8e3fd30606030636m44e3ce28k9d0fb6938947d4b2@mail.gmail.com>
	 <200606031828.k53ISSgr012167@laptop11.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/3/06, Horst von Brand <vonbrand@inf.utfsm.cl> wrote:
> Paolo Ciarrocchi <paolo.ciarrocchi@gmail.com> wrote:
> > On 11/15/05, Greg KH <greg@kroah.com> wrote:
> > [...]
> > > >       http://linux.tar.bz/articles/2.6-development_process
> > >
> > > Ah, a very nice summary.
> > >
> > > Paolo, can I use this document as a base for this section in the HOWTO
> > > file (with proper attribution of course.)
> >
> > That article is now living in a git tree, it now contains only spell
> > checks but I plan to work more on it in the next few days.
>
> I'd break it up into logical pieces (i.e., chapters...)

Yup, already in my todo list.

> The lines are way too long for easy reading.

Ok, I'll try to work on it.

> There are several other tools to check kernel quality: sparse, the
> lockcheck, ... And don't forget about the various debugging config options

Mmmh... Right, but the goal of the document was mainly to document the
process not the tools. However, that's a good comment.

> There are required tools for serious kernel development, i.e. git and its
> entournage. Link to them.

Ok.

> You mention that patches cook in -mm for a while, but you don't tell what
> that is beforehand. In general, a high-level overview of the current
> git-based development would be useful, and the various important git kernel
> trees and the patch flow among them.

Ok.

> Don't be shy in mentioning the stuff under Documentation in your nearest
> kernel source!

Right.

> Perhaps do an asccidoc format, to be able to create HTML?

Sure, but I don't know how to do it.

Patches are more then welcome :-)

Thank you for your valuable comments!!

Ciao,
-- 
Paolo
http://paolociarrocchi.googlepages.com
