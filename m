Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261186AbVEKRVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbVEKRVN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 13:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261914AbVEKRVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 13:21:13 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:36276 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261986AbVEKRVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 13:21:07 -0400
Date: Wed, 11 May 2005 18:21:05 +0100 (BST)
From: James Simmons <jsimmons@www.infradead.org>
X-X-Sender: jsimmons@pentafluge.infradead.org
To: Karel Kulhavy <clock@twibright.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: PC speaker input device
In-Reply-To: <20050511153314.GA24815@kestrel>
Message-ID: <Pine.LNX.4.56.0505111820200.32222@pentafluge.infradead.org>
References: <20050511153314.GA24815@kestrel>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Hello
> 
> PC speaker (CONFIG_INPUT_PCSPKR) is in kernel make menuconfig
> 2.6.11-gentoo-r5 -> Device Drivers -> Input device support
> 
> PC speaker is output device. Why is output device in input device
> submenu? Isn't this a mistake?

Some keyboards have built in speakers. 
