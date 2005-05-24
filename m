Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261369AbVEXSN0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261369AbVEXSN0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 May 2005 14:13:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261425AbVEXSN0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 May 2005 14:13:26 -0400
Received: from colin.muc.de ([193.149.48.1]:44806 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261369AbVEXSNY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 May 2005 14:13:24 -0400
Date: 24 May 2005 20:13:19 +0200
Date: Tue, 24 May 2005 20:13:19 +0200
From: Andi Kleen <ak@muc.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: akpm@osdl.org, davem@davemloft.net, linux-kernel@vger.kernel.org,
       systemtap@sources.redhat.com
Subject: Re: [PATCH 3/5] Kprobes: Temporary disarming of reentrant probe for x86_64
Message-ID: <20050524181319.GE86233@muc.de>
References: <20050524101532.GA27215@in.ibm.com> <20050524101712.GA27186@in.ibm.com> <20050524101840.GB27186@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050524101840.GB27186@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2005 at 03:48:40PM +0530, Prasanna S Panchamukhi wrote:
> 
> This patch includes x86_64 architecture specific changes to support temporary
> disarming on reentrancy of probes.

Fine for me (for after 2.6.12)

-Andi
