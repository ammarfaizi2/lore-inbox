Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWBTPNi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWBTPNi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 10:13:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWBTPNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 10:13:38 -0500
Received: from ozlabs.org ([203.10.76.45]:21988 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1030280AbWBTPNh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 10:13:37 -0500
Date: Tue, 21 Feb 2006 02:12:15 +1100
From: Anton Blanchard <anton@samba.org>
To: Roland Dreier <rolandd@cisco.com>
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 07/22] Hypercall definitions
Message-ID: <20060220151215.GC19895@krispykreme>
References: <20060218005532.13620.79663.stgit@localhost.localdomain> <20060218005721.13620.84990.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218005721.13620.84990.stgit@localhost.localdomain>
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Do these defines belong in the ehca driver, or should they be put
> somewhere in generic hypercall support?

Agreed, I think they should go into include/asm-powerpc/hvcall.h

Anton
