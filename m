Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266155AbUG1DD7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266155AbUG1DD7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 23:03:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266163AbUG1DD7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 23:03:59 -0400
Received: from wombat.indigo.net.au ([202.0.185.19]:56071 "EHLO
	wombat.indigo.net.au") by vger.kernel.org with ESMTP
	id S266155AbUG1DD6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 23:03:58 -0400
Date: Wed, 28 Jul 2004 11:16:08 +0800 (WST)
From: Ian Kent <raven@themaw.net>
X-X-Sender: raven@wombat.indigo.net.au
To: Matt Mackall <mpm@selenic.com>
cc: "Adam J. Richter" <adam@yggdrasil.com>, akpm@osdl.org,
       gotrooted@pop.com.br, linux-kernel@vger.kernel.org, maillist@jg555.com,
       ramon.rey@hispalinux.es
Subject: Re: Future devfs plans (sorry for previous incomplete message)
In-Reply-To: <20040727010345.GU5414@waste.org>
Message-ID: <Pine.LNX.4.58.0407281114560.12555@wombat.indigo.net.au>
References: <200407261737.i6QHbff04878@freya.yggdrasil.com>
 <20040727010345.GU5414@waste.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam, SpamAssassin (score=-2.5, required 8,
	EMAIL_ATTRIBUTION, IN_REP_TO, QUOTED_EMAIL_TEXT, REFERENCES,
	REPLY_WITH_QUOTES, USER_AGENT_PINE)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Jul 2004, Matt Mackall wrote:

> On Mon, Jul 26, 2004 at 10:37:41AM -0700, Adam J. Richter wrote:
> > 	devfs allows for creation of devices when user level programs
> > need them rather than based on "hot plug" or modprobe-related events,
> > neither of which do not exist for many devices and do not necessarily
> > indicate need for the driver.
> 
> One wonders if autofs can be made to do the same.

Do what exactly.

There is absolutly no infrastructure in autofs to create device files.

Ian

