Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262269AbVGKSAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262269AbVGKSAq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 14:00:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262265AbVGKR6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 13:58:49 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:58056 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S262141AbVGKR5c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 13:57:32 -0400
Date: Mon, 11 Jul 2005 19:57:00 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Horst von Brand <vonbrand@inf.utfsm.cl>
cc: Pekka Enberg <penberg@cs.helsinki.fi>, Bryan Henderson <hbryan@us.ibm.com>,
       Andrew Morton <akpm@osdl.org>, bfields@fieldses.org,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum 
In-Reply-To: <200507111713.j6BHDUGd001817@laptop11.inf.utfsm.cl>
Message-ID: <Pine.LNX.4.61.0507111950150.3728@scrub.home>
References: <200507111713.j6BHDUGd001817@laptop11.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 11 Jul 2005, Horst von Brand wrote:

> > I don't generally disagree with that, I just think that defines are not 
> > part of that list.
> 
> Covered in "bad coding style" and "hard to read code", at least.

Somehow I missed the last lkml debate about where simple defines where a 
problem.

> > Look, it's great that you do reviews, but please keep in mind it's the 
> > author who has to work with code and he has to be primarily happy with, 
> > so you don't have to point out every minor issue.
> 
> Wrong. The author has to work with the code, but there are much more people
> that have to read it now and fix it in the future. It doesn't make sense
> having everybody using their own indentation style, variable naming scheme,
> and ways of defining constants.

I didn't say this, I said "minor issues". Please read more carefully.

bye, Roman
