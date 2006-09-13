Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWIMO3K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWIMO3K (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:29:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWIMO3K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:29:10 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:5254 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S1750872AbWIMO3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:29:09 -0400
Subject: Re: Soft Lockup detected on cpu#0
From: Lee Revell <rlrevell@joe-job.com>
To: Benjamin Schindler <bschindler@student.ethz.ch>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4507B77F.1040907@student.ethz.ch>
References: <4507B77F.1040907@student.ethz.ch>
Content-Type: text/plain
Date: Wed, 13 Sep 2006 10:29:56 -0400
Message-Id: <1158157797.3768.26.camel@mindpipe>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-09-13 at 09:47 +0200, Benjamin Schindler wrote:
> EIP is at log_do_checkpoint+0xa0/0x134
>  EFLAGS: 00000202    Not tainted    (2.6.16/suspend2/r1 #4) 

Do you have the same problem without the suspend2 patch applied?

Problems with out-of-tree patched kernels should be reported to the
maintainer of the patches.

Lee

