Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932525AbVKOFNJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932525AbVKOFNJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Nov 2005 00:13:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932526AbVKOFNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Nov 2005 00:13:02 -0500
Received: from mail.kroah.org ([69.55.234.183]:33225 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S932524AbVKOFMo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Nov 2005 00:12:44 -0500
Date: Mon, 14 Nov 2005 20:38:46 -0800
From: Greg KH <greg@kroah.com>
To: Coywolf Qi Hunt <coywolf@gmail.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] HOWTO do Linux kernel development
Message-ID: <20051115043846.GA28005@kroah.com>
References: <20051114220709.GA5234@kroah.com> <2cd57c900511141708y5d11fd34n@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2cd57c900511141708y5d11fd34n@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2005 at 09:08:30AM +0800, Coywolf Qi Hunt wrote:
> 2005/11/15, Greg KH <gregkh@suse.de>:
> > So, I've been working on a document for the past week or so to help
> > alleviate a lot of these problems.  If nothing else, it should be a place
> > where anyone can point someone to when they ask the common questions, or
> > do something in the not-correct way.  I'd like to add this to the Linux
> > kernel source tree, so it will be kept up to date over time, as things
> > change (like the development process.)  Ideally I'd like to put it in
> > the main directory as HOWTO, but I don't know how others feel about
> 
> You put it in the top directory to draw the most attention? Compare to
> source trees of other kernel projects, Linux source tree looks clean.
> Please don't spoil that. What's wrong with Documentation/ ?

People do not seem to even realize Documentation/ is there :(

Now if those same people would notice anything in the root directory
either, is another story...

It's just a suggestion.

thanks,

greg k-h
