Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262652AbTJAXXG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 19:23:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262661AbTJAXXG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 19:23:06 -0400
Received: from fw.osdl.org ([65.172.181.6]:50848 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262652AbTJAXXD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 19:23:03 -0400
Date: Wed, 1 Oct 2003 16:22:53 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Chris Wright <chrisw@osdl.org>
cc: James Morris <jmorris@redhat.com>, Rik van Riel <riel@redhat.com>,
       <greg@kroah.com>, <linux-kernel@vger.kernel.org>,
       <vserver@solucorp.qc.ca>
Subject: Re: sys_vserver
In-Reply-To: <20031001161442.B14425@osdlab.pdx.osdl.net>
Message-ID: <Pine.LNX.4.44.0310011620440.6077-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 1 Oct 2003, Chris Wright wrote:
> 
> Doesn't sound like 2.6 material.

Agreed. I know virtualization is fairly high up on the list of things that
people ask for, and some people actually end up using UML for that. But 
right now it's just a system call number placeholder, not something that 
will go in. 

And I suspect you'll find a number of vendors who start integrating
patches into their "server release" thing if there truly is enough
pressure from users. Which is fine.

		Linus

