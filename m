Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261885AbUANP6c (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 10:58:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261973AbUANP6c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 10:58:32 -0500
Received: from mail-04.iinet.net.au ([203.59.3.36]:16866 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261885AbUANP6a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 10:58:30 -0500
Date: Wed, 14 Jan 2004 23:58:42 +0800 (WST)
From: raven@themaw.net
To: Mike Waychison <Michael.Waychison@Sun.COM>
cc: autofs mailing list <autofs@linux.kernel.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [autofs] [RFC] Towards a Modern Autofs
In-Reply-To: <4004409C.6040900@sun.com>
Message-ID: <Pine.LNX.4.58.0401142351470.1783@raven.themaw.net>
References: <Pine.LNX.4.33.0401130932460.10047-100000@wombat.indigo.net.au>
 <4004409C.6040900@sun.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004, Mike Waychison wrote:

> >
> My proposal uses filesystems for all automount mechanism *except* 
> expiry. I see expiry as a VFS service, and strongly believe that this is 
> where it belongs.
> 

I'm certainly thinking alot about this and have made quite a bit of 
progress thanks to the patiience of all.

Now it think it may be time to ponder the expire mechanism.

I was thinking it might be good for me to write up a specification based 
on the discussion so far to make sure that we all have the same 
understanding of what has been discussed. Perhaps this could allow for a 
specification to follow.

Good idea or not?

Ian

