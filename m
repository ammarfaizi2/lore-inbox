Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261290AbUJ3Tu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261290AbUJ3Tu1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261288AbUJ3Tu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 15:50:27 -0400
Received: from hera.cwi.nl ([192.16.191.8]:16011 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S261294AbUJ3TuJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 15:50:09 -0400
Date: Sat, 30 Oct 2004 21:42:35 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Adrian Bunk <bunk@stusta.de>
Cc: Andries.Brouwer@cwi.nl, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] small partitions/msdos cleanups
Message-ID: <20041030194235.GB15792@apps.cwi.nl>
References: <20041030175937.GQ4374@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041030175937.GQ4374@stusta.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 30, 2004 at 07:59:37PM +0200, Adrian Bunk wrote:

> The patch below makes the following changes to the msdos partition code:
> - remove CONFIG_NEC98_PARTITION leftovers
> - make parse_bsd static

No objections at all.

Andries
