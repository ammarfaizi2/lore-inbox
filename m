Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264619AbSKDBip>; Sun, 3 Nov 2002 20:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264621AbSKDBip>; Sun, 3 Nov 2002 20:38:45 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40115 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S264619AbSKDBio>;
	Sun, 3 Nov 2002 20:38:44 -0500
Date: Sun, 3 Nov 2002 17:40:37 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Jos Hulzink <josh@stack.nl>
cc: Vojtech Pavlik <vojtech@suse.cz>, Jeff Garzik <jgarzik@pobox.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Petition against kernel configuration options madness...
In-Reply-To: <200211032325.28397.josh@stack.nl>
Message-ID: <Pine.LNX.4.33L2.0211031738400.10796-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Nov 2002, Jos Hulzink wrote:

| On Sunday 03 November 2002 21:13, Vojtech Pavlik wrote:
| >
| > All the needed options ARE enabled by default. (check arch/i386/defconfig)
|
| Now all you need is the users to know "make defconfig". I compile kernels since 1.2.13, but I didn't know the option till today. Sure, my fault, but I'm sure I'm not the only one.
|
| Detail: IMHO the USB keyboard and mouse support should be on, and DRI should be enabled for all video cards, but that is a minor issue...

so while some people are attempting to "fix" this with
defconfig or mostlikelyconfig, I'd like to remind people
of the post-halloween doc from Dave Jones.  He addresses
this stuff in there.  Does it possibly need even more
emphasis there?  and stronger hints for people to at
least browse it before using 2.5.x for the first time?

-- 
~Randy

