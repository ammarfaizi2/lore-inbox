Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264922AbTLRDYq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 22:24:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264923AbTLRDYq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 22:24:46 -0500
Received: from [24.35.117.106] ([24.35.117.106]:1920 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264922AbTLRDYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 22:24:43 -0500
Date: Wed, 17 Dec 2003 22:24:17 -0500 (EST)
From: Thomas Molina <tmolina@cablespeed.com>
X-X-Sender: tmolina@localhost.localdomain
To: Andrew Morton <akpm@osdl.org>
cc: Christian Axelsson <smiler@lanil.mine.nu>, andrew@walrond.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-mm1
In-Reply-To: <20031217035105.3c0bd533.akpm@osdl.org>
Message-ID: <Pine.LNX.4.58.0312172220060.2348@localhost.localdomain>
References: <20031217014350.028460b2.akpm@osdl.org> <200312171037.16969.andrew@walrond.org>
 <3FE039F5.5030703@lanil.mine.nu> <20031217035105.3c0bd533.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 17 Dec 2003, Andrew Morton wrote:

> Christian Axelsson <smiler@lanil.mine.nu> wrote:
> >
> > Andrew Walrond wrote:
> > > On Wednesday 17 Dec 2003 9:43 am, Andrew Morton wrote:
> > 
> > > What are your intentions with -mm when you take over 2.6? Is any of -mm 
> > > getting into 2.6 before 2.6.0 release? Is it mainly queued for 2.6.1?
> 
> We'll start merging it up after 2.6.0.  It'll be quite a lot of work,
> actually - a lot of things have been parked in -mm for some time and may
> not have had sufficiently wide testing, especially on non-i386.  I need to
> ask the originators and others to re-review and retest some things.
> 
> > I would like to know aswell :)
> > Will you be "bleeding edge" maintainer aswell or will that be handed 
> > over to someone else?
> 
> I guess I'll keep -mm going until there's a reason not to.

Quite frankly I am becoming concerned about the number of patches that are 
queued for post 2.6.0.  It is beginning to look like 2.6.0 might be nice 
and quiet while 2.6.1+ are going to be quite messy as all the things "on 
hold" get put in.

I'm going to do my part by pounding heavily on -mm kernels since that 
appears where all this is ending up.  
