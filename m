Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932303AbVIEIad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932303AbVIEIad (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 04:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVIEIad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 04:30:33 -0400
Received: from mail.dvmed.net ([216.237.124.58]:54242 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932303AbVIEIac (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 04:30:32 -0400
Message-ID: <431C021C.2030603@pobox.com>
Date: Mon, 05 Sep 2005 04:30:20 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: drzeus@drzeus.cx, Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] ISA DMA suspend for i386
References: <200509050815.j858FWrw027844@hera.kernel.org>
In-Reply-To: <200509050815.j858FWrw027844@hera.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux Kernel Mailing List wrote:
> tree c04db2abe5b75fd8c5e40e4365aa9d267bc66b7d
> parent 2a23b5d1e119fd10e25b8e93464c8d549f5a5c5d
> author Pierre Ossman <drzeus@drzeus.cx> Sun, 04 Sep 2005 05:56:54 -0700
> committer Linus Torvalds <torvalds@evo.osdl.org> Mon, 05 Sep 2005 14:06:14 -0700
> 
> [PATCH] ISA DMA suspend for i386
> 
> Reset the ISA DMA controller into a known state after a suspend.  Primary
> concern was reenabling the cascading DMA channel (4).
> 
> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
> Signed-off-by: Andrew Morton <akpm@osdl.org>
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>

Where is CONFIG_PM?

	Jeff


