Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030209AbVIVESK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030209AbVIVESK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 00:18:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965227AbVIVESK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 00:18:10 -0400
Received: from mail24.sea5.speakeasy.net ([69.17.117.26]:10458 "EHLO
	mail24.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S965225AbVIVESI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 00:18:08 -0400
Date: Thu, 22 Sep 2005 00:18:06 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@excalibur.intercode
To: Eric Dumazet <dada1@cosmosbay.com>
cc: linux-kernel@vger.kernel.org, netfilter-devel@lists.netfilter.org,
       netdev@vger.kernel.org, Andi Kleen <ak@suse.de>
Subject: Re: [PATCH 0/3] netfilter : 3 patches to boost ip_tables performance
In-Reply-To: <4331CFA7.50104@cosmosbay.com>
Message-ID: <Pine.LNX.4.63.0509220017430.6397@excalibur.intercode>
References: <432EF0C5.5090908@cosmosbay.com> <200509191948.55333.ak@suse.de>
 <432FDAC5.3040801@cosmosbay.com> <200509201830.20689.ak@suse.de>
 <433082DE.3060308@cosmosbay.com> <43308324.70403@cosmosbay.com>
 <4331CFA7.50104@cosmosbay.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2005, Eric Dumazet wrote:

> I have reworked net/ipv4/ip_tables.c to boost its performance, and post three
> patches.

Do you have any performance measurements?


- James
-- 
James Morris
<jmorris@namei.org>
