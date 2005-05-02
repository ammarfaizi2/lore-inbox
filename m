Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261756AbVEBUTG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbVEBUTG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:19:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261758AbVEBUTF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:19:05 -0400
Received: from ns2.suse.de ([195.135.220.15]:492 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S261756AbVEBUS6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:18:58 -0400
Date: Mon, 2 May 2005 22:18:57 +0200
From: Andi Kleen <ak@suse.de>
To: YhLu <YhLu@tyan.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86-64 dual core mapping
Message-ID: <20050502201857.GS7342@wotan.suse.de>
References: <3174569B9743D511922F00A0C943142309B07C12@TYANWEB>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3174569B9743D511922F00A0C943142309B07C12@TYANWEB>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 12:41:31PM -0700, YhLu wrote:
> I'm using LinuxBIOS and there is no acpi in that. Also I have tried Normal
> BIOS, it also produce that.
> 
> Did you check my patch? It fixed that.

I dont think it is a correct, and Suresh is right that it 
will break Intel setups.

I will investigate this evening and see if I can reproduce it
on Simnow.

-Andi
