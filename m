Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268114AbUH1CrO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268114AbUH1CrO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 22:47:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268115AbUH1CrO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 22:47:14 -0400
Received: from science.horizon.com ([192.35.100.1]:35657 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S268114AbUH1CrN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 22:47:13 -0400
Date: 28 Aug 2004 02:47:12 -0000
Message-ID: <20040828024712.29061.qmail@science.horizon.com>
From: linux@horizon.com
To: jlcooke@engsoc.org, linux-kernel@vger.kernel.org
Subject: Re: Preliminary paper on collisions in SHA-2 Family
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The paper is NOT reporting a collision or attack; it's just reporting
a flaw in a previous security claim.  An attack was claimed to be
ineffective on SHA-2 because one step was computationally very expensive.

This paper shows that it's not all that expensive, so the security claim
needs to be re-examined; perhaps the attack can be made to work after all.
