Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750704AbWAPM0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750704AbWAPM0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 07:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750712AbWAPM0c
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 07:26:32 -0500
Received: from ns.suse.de ([195.135.220.2]:15254 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750709AbWAPM02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 07:26:28 -0500
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [PATCH 3/3] omit symbol size field in print_symbol()
Date: Mon, 16 Jan 2006 13:22:56 +0100
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org
References: <20060116121611.GA539@miraclelinux.com> <20060116121834.GD539@miraclelinux.com>
In-Reply-To: <20060116121834.GD539@miraclelinux.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601161322.56800.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 16 January 2006 13:18, Akinobu Mita wrote:
> I can't find useful usage for the symbol size in print_symbol().
> And symbolsize seems to be fixed when vmlinux or modules are compiled.
> So we can calculate it from vmlinux or modules.

Also not applied.

-Andi

