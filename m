Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261446AbVAXGCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261446AbVAXGCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 01:02:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261447AbVAXGCL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 01:02:11 -0500
Received: from pimout2-ext.prodigy.net ([207.115.63.101]:52115 "EHLO
	pimout2-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261446AbVAXGCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 01:02:09 -0500
Date: Sun, 23 Jan 2005 22:02:01 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Ram?n Rey Vicente <rrey@usuarios.retecal.es>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6.11-rc2] Badness in local_bh_enable at kernel/softirq.c:140
Message-ID: <20050124060201.GA2250@taniwha.stupidest.org>
References: <41F443BE.1030108@usuarios.retecal.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41F443BE.1030108@usuarios.retecal.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2005 at 01:39:26AM +0100, Ram?n Rey Vicente wrote:

> Badness in local_bh_enable at kernel/softirq.c:140

The cause of this was reverted earlier today.


  --cw
