Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268341AbUHYFBm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268341AbUHYFBm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Aug 2004 01:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268479AbUHYFAv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Aug 2004 01:00:51 -0400
Received: from ozlabs.org ([203.10.76.45]:5553 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268464AbUHYFAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Aug 2004 01:00:46 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16684.7365.879976.224551@cargo.ozlabs.ibm.com>
Date: Wed, 25 Aug 2004 14:59:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: Ryan Arnold <rsa@us.ibm.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linuxppc64-dev <linuxppc64-dev@lists.linuxppc.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] interrupt driven hvc_console as vio device
In-Reply-To: <1093394937.3402.83.camel@localhost>
References: <1093394937.3402.83.camel@localhost>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ryan Arnold writes:

> Paul MacKerras should probably approve this patch since it includes
> arch/ppc64/ changes.

Looks OK to me.

Paul.
