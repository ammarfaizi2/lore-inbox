Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbTLYEHi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Dec 2003 23:07:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTLYEHi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Dec 2003 23:07:38 -0500
Received: from mail-03.iinet.net.au ([203.59.3.35]:54913 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261190AbTLYEHh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Dec 2003 23:07:37 -0500
Date: Thu, 25 Dec 2003 12:07:33 +0800 (WST)
From: Ian Kent <raven@themaw.net>
To: Andrew Morton <akpm@osdl.org>
cc: Greg KH <greg@kroah.com>, <torvalds@osdl.org>, <ULMO@Q.NET>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] clean up fs/devfs/base.c
In-Reply-To: <20031224103016.37cf5ea3.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0312251152440.3691-100000@raven.themaw.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Dec 2003, Andrew Morton wrote:

> > 
> > Oh, I know it does.  That was just a "convert to proper coding format in
> > 15 minutes" patch.  You should start with that and work from there.
> > But, if you are going to do this, remember to submit in incremental
> > changes.  I suggest this patch go in, as it is just a reformatting,
> > nothing else.  Then you can work from there, changing the actual logic
> > of the code.
> 
> Yup, just whitespace fixes please.  I don't think I have the energy for a
> big cleanup exercise right now, and it's not really appropriate.
> 

OK. Didn't see this yet.

I'll test what I have and get an initial patch to you.

Ian

