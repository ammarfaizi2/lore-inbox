Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269572AbTGJUSA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 16:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269578AbTGJUR7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 16:17:59 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:10897 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269572AbTGJUR4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 16:17:56 -0400
Date: Thu, 10 Jul 2003 13:20:12 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Chuck Luciano <chuck@mrluciano.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: My own 3.5G patch plus question on Ingo's 4G/$G patch
Message-ID: <810600000.1057868412@flay>
In-Reply-To: <NFBBKNADOLMJPCENHEALKEAHGBAA.chuck@mrluciano.com>
References: <NFBBKNADOLMJPCENHEALKEAHGBAA.chuck@mrluciano.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On the subject of the 4G/4G patch, I started with 2.5.74, added 
> patch-2.5.74-bk1 and http://redhat.com/~mingo/4g-patches/4g-2.5.74-F8
> and I get a hunk that fails:
> 
> patching file include/asm-i386/mmu_context.h
> Hunk #1 FAILED at 29.
> Hunk #2 succeeded at 38 (offset -5 lines).
> Hunk #4 FAILED at 75.
> 2 out of 4 hunks FAILED -- saving rejects to file include/asm-i386/mmu_context.h.rej
> 
> Is/are there a patch(es) that I'm missing?

Put it on top of the -bk6 snapshot.

M.

