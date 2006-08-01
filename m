Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751231AbWHADoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbWHADoY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751529AbWHADoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:44:24 -0400
Received: from ns.suse.de ([195.135.220.2]:48276 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1751231AbWHADoX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:44:23 -0400
Date: Tue, 01 Aug 2006 05:44:22 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: [PATCH][0/2] x86_64: introduction
Message-ID: <44cece16.2NFojZWtvQyDQmvJ%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Still got two bug fix patches to be included by popular demand:

- Fix backtracing through interrupt stacks
(previously it could crash with fallback) 
- Fix hang with CONFIG_IOMMU_DEBUG

Hopefully the really last now unless something catastrophic comes up.

-Andi
