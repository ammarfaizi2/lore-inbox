Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVKOWGG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVKOWGG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 17:06:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932136AbVKOWGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 17:06:06 -0500
Received: from xproxy.gmail.com ([66.249.82.194]:64643 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932134AbVKOWGE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 17:06:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Y624XEcwjKf1iDTX6tmGEmoekmNYMScKi9UFO+p5xPhKs7MuMrCAYqcQxZQopq/CdyxKlgF/vtd0XmJB1NO0vafuCobcPkYh5HDocINGngbhXyA6y49qUAWO/c/adiCdR1HYB1s/XWnWos8IKbI1F19kDCgx9dYujdXKO2zVlE8=
Message-ID: <9a8748490511151406y72e82354w5c5599ea6201d38e@mail.gmail.com>
Date: Tue, 15 Nov 2005 23:06:04 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Greg KH <gregkh@suse.de>
Subject: Re: [RFC] HOWTO do Linux kernel development - take 2
Cc: linux-kernel@vger.kernel.org, greg@kroah.com
In-Reply-To: <20051115210459.GA11363@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20051115210459.GA11363@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/05, Greg KH <gregkh@suse.de> wrote:
> Here's an updated version of the "HOTO do Linux kernel development"
> document that I've been working on.
>
> For a description of why I started this, please see:
>         http://thread.gmane.org/gmane.linux.kernel/348689
>
> I've addressed all of the comments that I have received, and flushed out
> the the TODO sections.  I'd appreciate any comments on this version, as
> I think it's looking pretty good and finished for now.  If no one
> objects, I'll send it in a patch for inclusion in the main tree soon.
>
[snip]
>
>   Documentation/applying-patches.txt
>     A good introduction describing exactly what a patch is, how to
>     create it, and how to apply it to the different development branches
>     of the kernel.
>
[snip]

I don't believe I mention anything about patch /creation/ in
applying-patches.txt, at least the point of the document when I wrote
it was to explain what a patch is, how to apply it and give a short
description of the various trees.
So, your description is accurate except for the "how to create it" bit.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
