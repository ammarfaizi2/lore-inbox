Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030674AbWKOQbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030674AbWKOQbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 11:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030670AbWKOQbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 11:31:12 -0500
Received: from ns1.suse.de ([195.135.220.2]:59789 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1030666AbWKOQbL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 11:31:11 -0500
From: Andi Kleen <ak@suse.de>
To: patches@x86-64.org
Subject: Re: [patches] [PATCH] x86-64: adjust pmd_bad()
Date: Wed, 15 Nov 2006 17:31:05 +0100
User-Agent: KMail/1.9.5
Cc: "Jan Beulich" <jbeulich@novell.com>, linux-kernel@vger.kernel.org
References: <455B3AF2.76E4.0078.0@novell.com>
In-Reply-To: <455B3AF2.76E4.0078.0@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611151731.06074.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 16:06, Jan Beulich wrote:
> Make pmd_bad() symmetrical to pgd_bad() and pud_bad(). At once,
> simplify them all.

Got them all, thanks. Including the two i386 patches on l-k.

I didn't include the ACPI warning patch -- that should go via Len Brown's 
tree. Perhaps you resend it to him/linux-acpi to make sure he gets it.

-Andi

