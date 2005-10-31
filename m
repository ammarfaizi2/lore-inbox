Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbVJaL2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbVJaL2L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 06:28:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751069AbVJaL2L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 06:28:11 -0500
Received: from extgw-uk.mips.com ([62.254.210.129]:59922 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S1751018AbVJaL2K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 06:28:10 -0500
Date: Mon, 31 Oct 2005 11:26:38 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] OSS MIPS drivers: "extern inline" -> "static inline"
Message-ID: <20051031112638.GA13561@linux-mips.org>
References: <20051030000526.GP4180@stusta.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051030000526.GP4180@stusta.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2005 at 02:05:26AM +0200, Adrian Bunk wrote:

> "extern inline" doesn't make much sense.

Thanks, applied.

  Ralf
