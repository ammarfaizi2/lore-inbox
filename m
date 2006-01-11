Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbWAKSqE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbWAKSqE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 13:46:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932539AbWAKSpx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 13:45:53 -0500
Received: from smtp.osdl.org ([65.172.181.4]:18335 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932604AbWAKSpi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 13:45:38 -0500
Date: Wed, 11 Jan 2006 10:45:20 -0800
From: Andrew Morton <akpm@osdl.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.15-mm3
Message-Id: <20060111104520.42a766d1.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.61.0601111924001.11765@scrub.home>
References: <20060111042135.24faf878.akpm@osdl.org>
	<Pine.LNX.4.61.0601111924001.11765@scrub.home>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman Zippel <zippel@linux-m68k.org> wrote:
>
> Hi,
> 
> On Wed, 11 Jan 2006, Andrew Morton wrote:
> 
> > -hrtimer-...
> 
> Andrew, why did you merge this one? :-(
> 

Because the egregious rename-the-whole-world parts got taken out and
everyone who'd looked at and worked on the code except for yourself was
happy with it.

Ignoring the objections of a long-standing and respected kernel developer
is not a thing I like to do, but fortunately it's very rare.

Can you summarise, yet again, in as few words as possible, what you find
wrong with it?  I'd really like to understand, but there were waay too many
lengthy emails..
