Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759125AbWLEIzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759125AbWLEIzX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 03:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968107AbWLEIzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 03:55:23 -0500
Received: from amsfep17-int.chello.nl ([62.179.120.12]:30431 "EHLO
	amsfep17-int.chello.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759029AbWLEIzW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 03:55:22 -0500
Subject: Re: -mm merge plans for 2.6.20
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061204204024.2401148d.akpm@osdl.org>
References: <20061204204024.2401148d.akpm@osdl.org>
Content-Type: text/plain
Date: Tue, 05 Dec 2006 09:47:29 +0100
Message-Id: <1165308449.9636.7.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> mm-call-into-direct-reclaim-without-pf_memalloc-set.patch
> mm-cleanup-and-document-reclaim-recursion.patch

Drop these, I'm not sure of them anymore. And I am starting to grow a
nagging feeling they are wrong.


