Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261357AbVCaL3n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVCaL3n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 06:29:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261351AbVCaL3n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 06:29:43 -0500
Received: from colin2.muc.de ([193.149.48.15]:8466 "HELO colin2.muc.de")
	by vger.kernel.org with SMTP id S261357AbVCaL3j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 06:29:39 -0500
Date: 31 Mar 2005 13:29:38 +0200
Date: Thu, 31 Mar 2005 13:29:38 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: SystemTAP <systemtap@sources.redhat.com>, akpm@osdl.org,
       davem@davemloft.net, ananth@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kprobes: Allow/deny probes on int3/breakpoint instruction?
Message-ID: <20050331112938.GJ24804@muc.de>
References: <20050331080714.GB31660@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050331080714.GB31660@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> This patch fixes the above problem by doing a proper exit while avoiding
> recursion.
> Any pointers/suggestions on the above issues will be helpful.

Patch is fine for x86-64.

-Andi

