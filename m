Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262198AbVCBTds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbVCBTds (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 14:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbVCBTds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 14:33:48 -0500
Received: from palrel13.hp.com ([156.153.255.238]:16281 "EHLO palrel13.hp.com")
	by vger.kernel.org with ESMTP id S262198AbVCBTdf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 14:33:35 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16934.5385.841758.628631@napali.hpl.hp.com>
Date: Wed, 2 Mar 2005 11:33:29 -0800
To: jes@trained-monkey.org (Jes Sorensen)
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org
Subject: Re: [patch - 2.6.11-rc5-mm1] genalloc - general purpose allocator
In-Reply-To: <16934.4191.474769.320391@jaguar.mkp.net>
References: <16934.4191.474769.320391@jaguar.mkp.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At the risk of asking the obvious: what's preventing genalloc to be
implemented in terms of mempool?

	--david
