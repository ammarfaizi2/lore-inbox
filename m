Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264409AbTLQLwS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Dec 2003 06:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTLQLwS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Dec 2003 06:52:18 -0500
Received: from fw.osdl.org ([65.172.181.6]:25035 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264409AbTLQLwQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Dec 2003 06:52:16 -0500
Date: Wed, 17 Dec 2003 03:51:05 -0800
From: Andrew Morton <akpm@osdl.org>
To: Christian Axelsson <smiler@lanil.mine.nu>
Cc: andrew@walrond.org, linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test11-mm1
Message-Id: <20031217035105.3c0bd533.akpm@osdl.org>
In-Reply-To: <3FE039F5.5030703@lanil.mine.nu>
References: <20031217014350.028460b2.akpm@osdl.org>
	<200312171037.16969.andrew@walrond.org>
	<3FE039F5.5030703@lanil.mine.nu>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Axelsson <smiler@lanil.mine.nu> wrote:
>
> Andrew Walrond wrote:
> > On Wednesday 17 Dec 2003 9:43 am, Andrew Morton wrote:
> 
> > What are your intentions with -mm when you take over 2.6? Is any of -mm 
> > getting into 2.6 before 2.6.0 release? Is it mainly queued for 2.6.1?

We'll start merging it up after 2.6.0.  It'll be quite a lot of work,
actually - a lot of things have been parked in -mm for some time and may
not have had sufficiently wide testing, especially on non-i386.  I need to
ask the originators and others to re-review and retest some things.

> I would like to know aswell :)
> Will you be "bleeding edge" maintainer aswell or will that be handed 
> over to someone else?

I guess I'll keep -mm going until there's a reason not to.

