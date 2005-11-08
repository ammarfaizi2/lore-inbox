Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030229AbVKHCIB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030229AbVKHCIB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Nov 2005 21:08:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030244AbVKHCH6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Nov 2005 21:07:58 -0500
Received: from ozlabs.org ([203.10.76.45]:40841 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030229AbVKHCHY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Nov 2005 21:07:24 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17264.2129.341199.334838@cargo.ozlabs.ibm.com>
Date: Tue, 8 Nov 2005 13:07:13 +1100
From: Paul Mackerras <paulus@samba.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       lhms-devel@lists.sourceforge.net
Subject: Re: [PATCH 1/4] revised Memory Add Fixes for ppc64
In-Reply-To: <20051108002548.GF5821@w-mikek2.ibm.com>
References: <20051104231552.GA25545@w-mikek2.ibm.com>
	<20051104231800.GB25545@w-mikek2.ibm.com>
	<1131149070.29195.41.camel@gaston>
	<20051108002548.GF5821@w-mikek2.ibm.com>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz writes:

> Here is a new version of the patch on top of 64k page support (actually
> 2.6.14-git10).  One filename also changed due to more merge changes.

So, should I send this on to Linus along with the original 2/4 and 3/4
you posted and the revised 4/4?

Paul.
