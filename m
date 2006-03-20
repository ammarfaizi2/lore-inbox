Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965183AbWCTTXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965183AbWCTTXz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 14:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965205AbWCTTXy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 14:23:54 -0500
Received: from mra04.ch.as12513.net ([82.153.252.44]:9105 "EHLO
	mra04.ch.as12513.net") by vger.kernel.org with ESMTP
	id S965183AbWCTTXx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 14:23:53 -0500
Subject: Re: Announcing crypto suspend
From: Peter Wainwright <prw@ceiriog.eclipse.co.uk>
To: Pavel Machek <pavel@suse.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20060320184459.GB24523@elf.ucw.cz>
References: <20060320080439.GA4653@elf.ucw.cz>
	 <1142879707.9475.4.camel@localhost.localdomain>
	 <20060320184459.GB24523@elf.ucw.cz>
Content-Type: text/plain
Date: Mon, 20 Mar 2006 19:26:37 +0000
Message-Id: <1142882798.9475.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-03-20 at 19:44 +0100, Pavel Machek wrote:

> suspend.sf.net works for me , can you check again?
> 
> Anyway, all the code that is needed is here:
> 
> cvs -z3 -d:pserver:anonymous@cvs.sourceforge.net:/cvsroot/suspend co suspend
> 
> Installation is little tricky, but there's HOWTO file in repository.
> 
> 								Pavel

You're right: my brain copied suspend.sf.net but my fingers did
swsusp.sf.net - force of habit; anyway, I've found your site
and pulled the CVS repository - will check it out.

Peter


