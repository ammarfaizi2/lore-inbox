Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751306AbWINEGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751306AbWINEGm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 00:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751311AbWINEGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 00:06:42 -0400
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:36281
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S1751306AbWINEGm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 00:06:42 -0400
Date: Wed, 13 Sep 2006 21:07:34 -0700 (PDT)
Message-Id: <20060913.210734.112613039.davem@davemloft.net>
To: jmorris@redhat.com
Cc: akpm@osdl.org, dwmw2@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH NET] add secmark headers to header-y
From: David Miller <davem@davemloft.net>
In-Reply-To: <Pine.LNX.4.44.0609121844450.26062-100000@redline.boston.redhat.com>
References: <Pine.LNX.4.44.0609121844450.26062-100000@redline.boston.redhat.com>
X-Mailer: Mew version 4.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Morris <jmorris@redhat.com>
Date: Tue, 12 Sep 2006 18:48:44 -0400 (EDT)

> This patch includes xt_SECMARK.h and xt_CONNSECMARK.h to the kernel 
> headers which are exported via 'make headers_install'.  This is needed to 
> allow userland code to be built correctly with these features.
> 
> Please apply, and consider for inclusion with 2.6.18 as a bugfix.
> 
> Signed-off-by: James Morris <jmorris@redhat.com>

Applied, thanks James.
