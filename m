Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750709AbVIJItb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750709AbVIJItb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Sep 2005 04:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750710AbVIJItb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Sep 2005 04:49:31 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25291 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750709AbVIJIta (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Sep 2005 04:49:30 -0400
Date: Sat, 10 Sep 2005 01:45:43 -0700
From: Andrew Morton <akpm@osdl.org>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com, bunk@stusta.de
Subject: Re: [RFC][MEGAPATCH] Change __ASSEMBLY__ to __ASSEMBLER__ (defined
 by GCC from 2.95 to current CVS)
Message-Id: <20050910014543.1be53260.akpm@osdl.org>
In-Reply-To: <97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>
References: <C670AD22-97CF-46AA-A527-965036D78667@mac.com>
	<20050903064124.GA31400@codepoet.org>
	<4319BEF5.2070000@zytor.com>
	<B9E70F6F-CC0A-4053-AB34-A90836431358@mac.com>
	<dfhs4u$1ld$1@terminus.zytor.com>
	<5A37B032-9BBD-4AEA-A9BF-D42AFF79BC86@mac.com>
	<9C47C740-86CF-48F1-8DB6-B547E5D098FF@mac.com>
	<97597F8E-DDCE-479F-AE8D-CC7DC75AB3C3@mac.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch seems to have a rather low value-to-noise ratio.  Why
on earth do we want to do this?
