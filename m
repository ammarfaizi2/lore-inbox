Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261705AbVAXWlB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261705AbVAXWlB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 17:41:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261606AbVAXWhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 17:37:51 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:34019 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261587AbVAXWg1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 17:36:27 -0500
Date: Mon, 24 Jan 2005 14:36:10 -0800
From: Chris Wedgwood <cw@f00f.org>
To: earny@net4u.de,
       Frank Dekervel|Smartlounge| <frank.dekervel@smartlounge.be>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2: Badness in local_bh_enable at kernel/softirq.c:140
Message-ID: <20050124223610.GA10120@taniwha.stupidest.org>
References: <200501242302.04493.frank.dekervel@smartlounge.be> <200501241919.29987.list-lkml@net4u.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501242302.04493.frank.dekervel@smartlounge.be> <200501241919.29987.list-lkml@net4u.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixed in -bk on Sunday.
