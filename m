Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422701AbWAMOsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422701AbWAMOsp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 09:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422702AbWAMOsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 09:48:45 -0500
Received: from tim.rpsys.net ([194.106.48.114]:2250 "EHLO tim.rpsys.net")
	by vger.kernel.org with ESMTP id S1422701AbWAMOso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 09:48:44 -0500
Subject: Re: [RFC: 2.6 patch] MTD_NAND_SHARPSL and MTD_NAND_NANDSIM should
	be tristate's
From: Richard Purdie <rpurdie@rpsys.net>
To: Adrian Bunk <bunk@stusta.de>
Cc: dwmw2@infradead.org, LKML <linux-kernel@vger.kernel.org>,
       linux-mtd@lists.infradead.org
In-Reply-To: <20060113114817.GG29663@stusta.de>
References: <20060113114817.GG29663@stusta.de>
Content-Type: text/plain
Date: Fri, 13 Jan 2006 14:45:02 +0000
Message-Id: <1137163503.6644.36.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-01-13 at 12:48 +0100, Adrian Bunk wrote:
> MTD_NAND=m and MTD_NAND_SHARPSL=y or MTD_NAND_NANDSIM=y are illegal 
> combinations that mustn't be allowed.
> 
> This patch fixes this bug by making MTD_NAND_SHARPSL and 
> MTD_NAND_NANDSIM tristate's.
> 
> Additionally, it fixes some whitespace damage at these options.
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> ---
> 
> This patch was already sent on:
> - 31 Dec 2005
> 


I can ack the MTD_NAND_SHARPSL part of the patch.

Richard

