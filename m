Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268667AbUI2RFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268667AbUI2RFQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Sep 2004 13:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268726AbUI2RFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Sep 2004 13:05:16 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:33233 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268667AbUI2RFB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Sep 2004 13:05:01 -0400
Subject: Re: 2.6.9-rc2-mm4 and nvidia 1.0-6111
From: Lee Revell <rlrevell@joe-job.com>
To: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, sboyce@blueyonder.co.uk
In-Reply-To: <200409291355.20281.norberto+linux-kernel@bensa.ath.cx>
References: <415A6EE6.1090404@blueyonder.co.uk>
	 <200409291355.20281.norberto+linux-kernel@bensa.ath.cx>
Content-Type: text/plain
Message-Id: <1096477498.1400.17.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 29 Sep 2004 13:04:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-29 at 12:55, Norberto Bensa wrote:
> Sid Boyce wrote:
> > Any help appreciated, also posted to nvidia forum.
> 
> I did revert these patches:
> 
> convert-references-to-remap_page_range-under-arch-and-documentation-to-remap_pfn_range.patch
> convert-users-of-remap_page_range-under-drivers-and-net-to-use-remap_pfn_range.patch
> convert-users-of-remap_page_range-under-include-asm--to-use-remap_pfn_range.patch
> convert-users-of-remap_page_range-under-sound-to-use-remap_pfn_range.patch
> for-mm-only-remove-remap_page_range-completely.patch
> introduce-remap_pfn_range-to-replace-remap_page_range.patch

Isn't there an nvidia-linux mailing list?  This is really OT for LKML.

Lee

