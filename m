Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262709AbVAQGQk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262709AbVAQGQk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 01:16:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262711AbVAQGQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 01:16:39 -0500
Received: from mail-ex.suse.de ([195.135.220.2]:24777 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262709AbVAQGQe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 01:16:34 -0500
Date: Mon, 17 Jan 2005 07:16:33 +0100
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] x86_64: kill stale mtrr_centaur_report_mcr
Message-ID: <20050117061633.GJ19187@wotan.suse.de>
References: <20050116074817.GX4274@stusta.de> <20050117055040.GE19187@wotan.suse.de> <20050117060746.GW4274@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117060746.GW4274@stusta.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 07:07:46AM +0100, Adrian Bunk wrote:
> I haven't tried to compile it, [...]

Please only submit compile tested patches in the future.

A cross compiler for x86-64 from i386 can be found at 
ftp://ftp.suse.com/pub/suse/x86_64/supplementary/CrossTools/8.1-i386/
(work with alien or rpm2cpio on non rpm systems too) 

-Andi
