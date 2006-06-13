Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932932AbWFMHGX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932932AbWFMHGX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 03:06:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932934AbWFMHGX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 03:06:23 -0400
Received: from ns1.suse.de ([195.135.220.2]:49809 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932932AbWFMHGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 03:06:22 -0400
From: Andi Kleen <ak@suse.de>
To: Eric Sandeen <sandeen@sgi.com>
Subject: Re: [PATCH] stack overflow checking for x86_64 / 2.6
Date: Tue, 13 Jun 2006 09:06:17 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <448DB363.6060102@sgi.com>
In-Reply-To: <448DB363.6060102@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606130906.17618.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Index: linux-2.6.16/arch/x86_64/Kconfig.debug
> ===================================================================
> --- linux-2.6.16.orig/arch/x86_64/Kconfig.debug	2006-03-19 23:53:29.000000000 -0600
> +++ linux-2.6.16/arch/x86_64/Kconfig.debug	2006-06-09 16:15:58.991377500 -0500

2.6.16? Of course the patch doesn't apply ... 

Patch submissions please always against current Linus tree.

-Andi
