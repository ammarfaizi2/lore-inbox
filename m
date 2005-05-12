Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbVELAEP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbVELAEP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 May 2005 20:04:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbVELAEO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 May 2005 20:04:14 -0400
Received: from colin.muc.de ([193.149.48.1]:35595 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261249AbVELAEI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 May 2005 20:04:08 -0400
Date: 12 May 2005 02:04:05 +0200
Date: Thu, 12 May 2005 02:04:05 +0200
From: Andi Kleen <ak@muc.de>
To: Ashok Raj <ashok.raj@intel.com>
Cc: "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 patches in -mm
Message-ID: <20050512000405.GA62935@muc.de>
References: <20050505151522.72d6deec.akpm@osdl.org> <20050507225850.GA21873@muc.de> <20050509172731.A14676@unix-os.sc.intel.com> <20050510015125.GB97046@muc.de> <20050510162221.A29090@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050510162221.A29090@unix-os.sc.intel.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch removes the assumption that LAPIC entries contain the BSP as its
> first entry. This is a slight improvement to the temporary fix submitted by
> Suresh Siddha. 

[...]

Patch is fine for me thanks.

-Andi
