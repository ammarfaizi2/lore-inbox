Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270685AbTG0Grm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 02:47:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270686AbTG0Grm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 02:47:42 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:39645 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S270685AbTG0Grl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 02:47:41 -0400
Date: Sun, 27 Jul 2003 09:02:52 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] kill annoying submenus in fs/Kconfig
Message-ID: <20030727070252.GD17724@louise.pinerecords.com>
References: <20030726195544.GA16160@louise.pinerecords.com> <20030726200903.73d17418.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030726200903.73d17418.rddunlap@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [rddunlap@osdl.org]
> 
> On Sat, 26 Jul 2003 21:55:44 +0200 Tomas Szepe <szepe@pinerecords.com> wrote:
> 
> | Patch against -bk3.
>
> Let me begin by saying that I find the menu arrangement (both before
> and after this patch) highly subjective.

I guess so.

> I.e., there's not necessarily a right or wrong. (RR:)
> I.e., in the absence of further input, some maintainer can decide.  :)
> 
> Given the above:
> I prefer short menus.  I find them more readable, with less clutter.
> So I don't mind them the way that they currently are.
> 
> OTOH, I don't care strongly either way.  I think that we should
> care more about how non-developers use and see 'make *config'
> than how kernel developers use and see it.

I can't see why we need to categorize ~50 (that is _two_ 80x25 screenfuls)
filesystems into 7 or so submenus.  The going back and forth in menuconfig
just to check if NFS and proc are enabled for a basic config is highly
annoying IMHO.  The categorization itself is a nice idea, though.

-- 
Tomas Szepe <szepe@pinerecords.com>
