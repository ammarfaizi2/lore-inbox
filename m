Return-Path: <linux-kernel-owner+w=401wt.eu-S932739AbXAQUWv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932739AbXAQUWv (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 15:22:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932742AbXAQUWv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 15:22:51 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:49831 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932740AbXAQUWu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 15:22:50 -0500
From: Hans-Peter Jansen <hpj@urpla.net>
To: linux-kernel@vger.kernel.org
Subject: Re: prioritize PCI traffic ?
Date: Wed, 17 Jan 2007 21:22:26 +0100
User-Agent: KMail/1.9.5
Cc: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
       Soeren Sonnenburg <kernel@nn7.de>
References: <1168859265.15294.8.camel@localhost> <1168869630.15294.44.camel@localhost> <45AB956A.5070103@linux.vnet.ibm.com>
In-Reply-To: <45AB956A.5070103@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701172122.27407.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. Januar 2007 15:53 schrieb Vaidyanathan Srinivasan:
>
> 33Mhz 32-bit PCI bus on typical PC can do around 100MB/sec... 

Substract roughly n * 5MB for VIA chipsets, where n is the age (1 <= n <= 
4), and even more for SIS, ATI..

Pete
