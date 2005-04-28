Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262051AbVD1Lfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262051AbVD1Lfs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 07:35:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262063AbVD1Lfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 07:35:48 -0400
Received: from extgw-uk.mips.com ([62.254.210.129]:49949 "EHLO
	bacchus.net.dhis.org") by vger.kernel.org with ESMTP
	id S262051AbVD1Lfj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 07:35:39 -0400
Date: Thu, 28 Apr 2005 12:35:05 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Benoit Boissinot <benoit.boissinot@ens-lyon.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 PATCH] remove include/asm-mips/hp-lj/*
Message-ID: <20050428113505.GN4876@linux-mips.org>
References: <20050427222227.GK3837@ens-lyon.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050427222227.GK3837@ens-lyon.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 12:22:27AM +0200, Benoit Boissinot wrote:

> This patch removes the unused file 
> include/asm-mips/hp-lj/asics.h (arch/mips/hp-lj was removed in 2.6.10
> but it seems this file was forgotten).
> 
> include/asm-mips/hp-lj should be removed as it will be empty after that.

Thanks, applied to the MIPS tree.

  Ralf
