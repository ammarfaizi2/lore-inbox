Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVEYPTX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVEYPTX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 11:19:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262373AbVEYPTX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 11:19:23 -0400
Received: from colin.muc.de ([193.149.48.1]:13316 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S262372AbVEYPTT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 11:19:19 -0400
Date: 25 May 2005 17:19:18 +0200
Date: Wed, 25 May 2005 17:19:18 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 2/5] Kprobes: Temporary disarming of reentrant probe for i386
Message-ID: <20050525151918.GB86087@muc.de>
References: <20050524101532.GA27215@in.ibm.com> <20050524101712.GA27186@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524101712.GA27186@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 03:47:12PM +0530, Prasanna S Panchamukhi wrote:
> 
> This patch includes i386 architecture specific changes to support temporary
> disarming on reentrancy of probes.

The patches are all fine from my side.

-Andi
