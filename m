Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262583AbVGMFTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262583AbVGMFTf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 01:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262588AbVGMFTd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 01:19:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:40405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262583AbVGMFTc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 01:19:32 -0400
Date: Tue, 12 Jul 2005 22:19:29 -0700
From: Pete Zaitcev <zaitcev@redhat.com>
To: mjt@nysv.org (Markus   =?UTF-8?B?VMO2cm5xdmlzdA==?=)
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB bugs in 2.6.11.8, 2.6.11.10 and 2.6.12.2
Message-Id: <20050712221929.557a0df6.zaitcev@redhat.com>
In-Reply-To: <mailman.1121132100.14735.linux-kernel2news@redhat.com>
References: <20050707133805.GC11013@nysv.org>
	<mailman.1121132100.14735.linux-kernel2news@redhat.com>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed version 2.0.0beta3 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Jul 2005 17:06:28 +0300, mjt@nysv.org (Markus   Törnqvist) wrote:

> Sorry about the bother, enabling K8 IOMMU fixed the issues.
> At least that's the most relevant change I made to the conf
> to fix it.

This is not a good reason for crashes though. All is well that ends
well, but perhaps Andi wants to make a mental note.

-- Pete
