Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932294AbWHKGmT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932294AbWHKGmT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 02:42:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932308AbWHKGmT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 02:42:19 -0400
Received: from liaag1ab.mx.compuserve.com ([149.174.40.28]:54454 "EHLO
	liaag1ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932294AbWHKGmS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 02:42:18 -0400
Date: Fri, 11 Aug 2006 02:37:30 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for review] [9/145] x86_64: Cleanup NMI interrupt
  path
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608110240_MC3-1-C7C3-777B@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060810193521.6A8C513B90@wotan.suse.de>

On Thu, 10 Aug 2006 21:35:21 +0200, Andi Kleen wrote:

> arch/i386/kernel/nmi.c     |   16 +++++++++++++---
> arch/i386/kernel/traps.c   |   24 +++++++++++-------------
> arch/x86_64/kernel/nmi.c   |   26 +++++++++++++++++++-------
> arch/x86_64/kernel/traps.c |    8 ++++----
> include/asm-i386/nmi.h     |    2 +-
> include/asm-x86_64/nmi.h   |   10 +++++++++-

Could you please change the title of this patch to "x86: whatever"
instead of "x86_64: whatever" so someone scanning titles can see
it affects i386?

-- 
Chuck

