Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVG0AMz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVG0AMz (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 20:12:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVG0AKc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 20:10:32 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58595 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262409AbVG0AKW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 20:10:22 -0400
Date: Tue, 26 Jul 2005 17:08:55 -0700
From: Andrew Morton <akpm@osdl.org>
To: Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl>
Cc: mkrufky@m1k.net, linux-kernel@vger.kernel.org
Subject: Re: MM kernels - how to keep on the bleeding edge?
Message-Id: <20050726170855.2e866abb.akpm@osdl.org>
In-Reply-To: <20050727020010.14852c38.astralstorm@gorzow.mm.pl>
References: <20050726185834.76570153.astralstorm@gorzow.mm.pl>
	<42E692E4.4070105@m1k.net>
	<20050726221506.416e6e76.astralstorm@gorzow.mm.pl>
	<42E69C5B.80109@m1k.net>
	<20050726144149.0dc7b008.akpm@osdl.org>
	<20050727004932.1b25fc5d.astralstorm@gorzow.mm.pl>
	<20050726161149.0c9c36fa.akpm@osdl.org>
	<20050727012558.5661d071.astralstorm@gorzow.mm.pl>
	<20050726163521.73c7ed08.akpm@osdl.org>
	<20050727020010.14852c38.astralstorm@gorzow.mm.pl>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Radoslaw "AstralStorm" Szkodzinski <astralstorm@gorzow.mm.pl> wrote:
>
> On Tue, 26 Jul 2005 16:35:21 -0700
> Andrew Morton <akpm@osdl.org> wrote:
> 
> > 
> > I did?
> > 
> 
> Exactly, I did untar it and I already had a directory called patches.
> Of course cleaning it up took no time, as fortunately I had no patches with
> exactly the same name and no series file in the directory above,
> 

hmm, I'll replace patches/ with broken-out/ to make those files the same as
the broken-out.tar.gz from -mm releases.

