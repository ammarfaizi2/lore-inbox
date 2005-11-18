Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030406AbVKRIAN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030406AbVKRIAN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 03:00:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVKRIAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 03:00:13 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:62133
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S932610AbVKRIAL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 03:00:11 -0500
Date: Thu, 17 Nov 2005 23:59:05 -0800 (PST)
Message-Id: <20051117.235905.117690472.davem@davemloft.net>
To: linux@dominikbrodowski.net
Cc: davej@redhat.com, hugh@veritas.com, akpm@osdl.org, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/11] unpaged: private write VM_RESERVED
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051118071208.GA15705@isilmar.linta.de>
References: <20051117205156.GH5772@redhat.com>
	<20051117.155856.44665420.davem@davemloft.net>
	<20051118071208.GA15705@isilmar.linta.de>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dominik Brodowski <linux@dominikbrodowski.net>
Date: Fri, 18 Nov 2005 08:12:08 +0100

> No. 2.6.15-rc1-git-as-of-yesterday and Hugh's patches plus original
> vbetool-0.3 works fine, but it plus vbetool-0.3-lrmi.patch breaks resume for
> this person's notebook, i.e. mine. And it's repeatable.

Ok, thanks for the datapoint.

DaveJ take note.
