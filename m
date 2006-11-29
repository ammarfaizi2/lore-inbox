Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967591AbWK2Tny@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967591AbWK2Tny (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Nov 2006 14:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967594AbWK2Tny
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Nov 2006 14:43:54 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:27266 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S967591AbWK2Tnx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Nov 2006 14:43:53 -0500
Date: Wed, 29 Nov 2006 19:43:46 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips tx4927 missing brace fix
Message-ID: <20061129194346.GA20892@linux-mips.org>
References: <200611292030.36170.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200611292030.36170.m.kozlowski@tuxland.pl>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2006 at 08:30:35PM +0100, Mariusz Kozlowski wrote:

> 	This patch adds missing brace at the end of toshiba_rbtx4927_irq_isa_init().

Thanks Mariusz!  Applied,

  Ralf
