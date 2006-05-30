Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751478AbWE3P4j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751478AbWE3P4j (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 11:56:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbWE3P4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 11:56:39 -0400
Received: from windsormachine.com ([216.8.138.2]:37605 "EHLO
	router.windsormachine.com") by vger.kernel.org with ESMTP
	id S1751521AbWE3P4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 11:56:38 -0400
Date: Tue, 30 May 2006 11:56:34 -0400 (EDT)
From: Mike Dresser <mdresser_l@windsormachine.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Asus K8N-VM Motherboard Ethernet Problem
In-Reply-To: <44793100.50707@perkel.com>
Message-ID: <Pine.LNX.4.64.0605301150160.15583@router.windsormachine.com>
References: <44793100.50707@perkel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-scanner: Scanned by Xamime-LT 0.1.5
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is there a problem with the forcedeth driver not being compatible with the 
> Asus K8N-VM motherboard? I installed Fedora Core 5 and the Ethernet doesn't

I have the ASUS K8N-VM CSM here(different variant), and it works "fine" 
with the forcedeth driver.  Throughput is fairly slow though, I average 
only about 25 meg/second with scp, on an Athlon64 3700+ talking to a dual 
opteron 265.

Also, jumbo frames are apparently not supported.

I may add on a pci-e network card at some point.

Mike

