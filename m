Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261201AbTERHqU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 03:46:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261202AbTERHqU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 03:46:20 -0400
Received: from louise.pinerecords.com ([213.168.176.16]:50379 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S261201AbTERHqT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 03:46:19 -0400
Date: Sun, 18 May 2003 09:59:10 +0200
From: Tomas Szepe <szepe@pinerecords.com>
To: Jeffrey Baker <jwbaker@acm.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HD DMA disabled in 2.4.21-rc2, works fine in 2.4.20
Message-ID: <20030518075910.GX3478@louise.pinerecords.com>
References: <20030517035612.GA543@noodles>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030517035612.GA543@noodles>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> [jwbaker@acm.org]
> 
> I have the same problem on VIA chipset.  IDE DMA is disabled in
> 2.4.21-rc2 but works fine otherwise:

Please post the relevant extract of your .config and dmesg output.

-- 
Tomas Szepe <szepe@pinerecords.com>
