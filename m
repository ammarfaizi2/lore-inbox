Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261654AbUE0RGT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261654AbUE0RGT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 May 2004 13:06:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264896AbUE0RGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 May 2004 13:06:18 -0400
Received: from ozlabs.org ([203.10.76.45]:54958 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261654AbUE0REr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 May 2004 13:04:47 -0400
Date: Fri, 28 May 2004 03:03:34 +1000
From: Anton Blanchard <anton@samba.org>
To: Thomas Zehetbauer <thomasz@hostmaster.org>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: CONFIG_IRQBALANCE for AMD64?
Message-ID: <20040527170334.GE23262@krispykreme>
References: <1085629714.6583.12.camel@hostmaster.org> <40B578F1.3090704@pobox.com> <1085675774.6583.23.camel@hostmaster.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1085675774.6583.23.camel@hostmaster.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> Seems to work, just like the i386 irqbalanced before it has been
> obsoleted by CONFIG_IRQBALANCE

No, CONFIG_IRQBALANCE is an x86 specific hack.

Anton
