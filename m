Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966955AbWKUJip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966955AbWKUJip (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 04:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966959AbWKUJip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 04:38:45 -0500
Received: from colin.muc.de ([193.149.48.1]:44297 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S966955AbWKUJio (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 04:38:44 -0500
Date: 21 Nov 2006 10:38:42 +0100
Date: Tue, 21 Nov 2006 10:38:42 +0100
From: Andi Kleen <ak@muc.de>
To: Vivek Goyal <vgoyal@in.ibm.com>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>
Subject: Re: [PATCH] x86_64: Align data segment to PAGE_SIZE boundary
Message-ID: <20061121093842.GA24407@muc.de>
References: <20061120162909.GJ11450@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120162909.GJ11450@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 11:29:09AM -0500, Vivek Goyal wrote:
> Hi Andi,
> 
> This patch was previously part of relocatable kernel series but now I have
> forked it out as it is required for 2.6.19 kernels and relocatable kernel
> patches have to wait.

I sent it to Linus. Thanks.

-Andi

