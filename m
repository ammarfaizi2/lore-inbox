Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265501AbUGDLFe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265501AbUGDLFe (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jul 2004 07:05:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265517AbUGDLFe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jul 2004 07:05:34 -0400
Received: from ozlabs.org ([203.10.76.45]:15500 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265508AbUGDLFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jul 2004 07:05:32 -0400
Date: Sun, 4 Jul 2004 21:04:43 +1000
From: Anton Blanchard <anton@samba.org>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, rddunlap@osdl.org
Subject: Re: [PATCH] gcc 3.5 fixes
Message-ID: <20040704110443.GI4923@krispykreme>
References: <20040704065811.GA4923@krispykreme> <20040704070144.GB4923@krispykreme> <200407041224.47578.bzolnier@elka.pw.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407041224.47578.bzolnier@elka.pw.edu.pl>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Can't we just remove these variables?

Certainly possible. Randy, does IKCONFIG_VERSION serve a purpose?

Anton
