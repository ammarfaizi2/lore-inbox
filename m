Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261735AbVD1Cir@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261735AbVD1Cir (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 22:38:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261740AbVD1Cir
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 22:38:47 -0400
Received: from 70-56-217-9.albq.qwest.net ([70.56.217.9]:29587 "EHLO
	montezuma.fsmlabs.com") by vger.kernel.org with ESMTP
	id S261735AbVD1Ciq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 22:38:46 -0400
Date: Wed, 27 Apr 2005 20:40:35 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: "Guo, Racing" <racing.guo@intel.com>
cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>,
       "Yu, Luming" <luming.yu@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]fix warning in porting lockless mce from x86_64 to i386
In-Reply-To: <16A54BF5D6E14E4D916CE26C9AD305750162F6E7@pdsmsx402.ccr.corp.intel.com>
Message-ID: <Pine.LNX.4.61.0504272039470.12903@montezuma.fsmlabs.com>
References: <16A54BF5D6E14E4D916CE26C9AD305750162F6E7@pdsmsx402.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Apr 2005, Guo, Racing wrote:

> Fix warning in porting lockless mce from x86_64 to i386
> 1. fix warning in set_bit
> 2. declare mcheck_init function
> 3. change to "fastcall" before do_machine_check

Hmm i think i may have missed the original patch, could you send it to me?

Thanks,
	Zwane
