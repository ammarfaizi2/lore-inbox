Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752677AbVHGUOp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752677AbVHGUOp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Aug 2005 16:14:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752679AbVHGUOo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Aug 2005 16:14:44 -0400
Received: from hockin.org ([66.35.79.110]:9432 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S1752677AbVHGUOo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Aug 2005 16:14:44 -0400
Date: Sun, 7 Aug 2005 13:14:38 -0700
From: Tim Hockin <thockin@hockin.org>
To: Erick Turnquist <jhujhiti@gmail.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Lost Ticks on x86_64
Message-ID: <20050807201438.GA4936@hockin.org>
References: <5348b8ba050806204453392f7f@mail.gmail.com.suse.lists.linux.kernel> <p73mznuc732.fsf@bragg.suse.de> <20050807174811.GA31006@hockin.org> <5348b8ba050807114616f84ee6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5348b8ba050807114616f84ee6@mail.gmail.com>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 07, 2005 at 02:46:50PM -0400, Erick Turnquist wrote:
> > Some BIOSes do not lock SMM, and you *could* turn it off at the chipset
> > level.
> 
> I don't see anything about SMM in my BIOS configuration even with the
> advanced options enabled... Turning it off at the chipset level sounds
> like a hardware hack - is it?

No, it's usually just a PCI register you can change.  Depends on your
chipset, though.
