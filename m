Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946122AbWJ0C1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946122AbWJ0C1k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 22:27:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946123AbWJ0C1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 22:27:40 -0400
Received: from cantor2.suse.de ([195.135.220.15]:50311 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1946122AbWJ0C1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 22:27:39 -0400
From: Andi Kleen <ak@suse.de>
To: "bibo,mao" <bibo.mao@intel.com>
Subject: Re: [PATCH 0/5] i386 create e820.c to handle e820/efi memory map table
Date: Thu, 26 Oct 2006 19:27:21 -0700
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <4540AA7E.4050703@intel.com>
In-Reply-To: <4540AA7E.4050703@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610261927.21536.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>   With this patch, function handling about bios memory map table is more
> explicit, easier to handle memmap table between legacy bios and efi bios.
>   This patch is divided fives parts, each parts can compile and run well in
> my machine. Any comments and suggestion is welcome.

Added thanks (although it was a little painful because 3 of the patches
didn't apply to mainline) 

-Andi
