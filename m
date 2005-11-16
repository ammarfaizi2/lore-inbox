Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030351AbVKPO6y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVKPO6y (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 09:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030352AbVKPO6y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 09:58:54 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:37576 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1030351AbVKPO6x (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 09:58:53 -0500
Subject: Re: 2.6.15-rc1 - NForce4 PCI-E agpgart support?
From: Arjan van de Ven <arjan@infradead.org>
To: Mark Knecht <markknecht@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com>
References: <5bdc1c8b0511160650k4a9e0575h29403a5de47af952@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 16 Nov 2005 15:58:21 +0100
Message-Id: <1132153102.2834.37.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 1.8 (+)
X-Spam-Report: SpamAssassin version 3.0.4 on pentafluge.infradead.org summary:
	Content analysis details:   (1.8 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[213.93.14.173 listed in dnsbl.sorbs.net]
	1.7 RCVD_IN_NJABL_DUL      RBL: NJABL: dialup sender did non-local SMTP
	[213.93.14.173 listed in combined.njabl.org]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 06:50 -0800, Mark Knecht wrote:
> Hi,
>    I downloaded and built 2.6.15-rc1 as a test assuming Ingo will
> release -rt support for this one of these days. (No rush Ingo!) It
> booted on my AMD64 machine and is running fine AFAICT.
> 
>    One thing I was expecting to see was agpgart support for the
> NForce4 chipset. Is this something that's coming or am I missing where
> the configuration is done?
> 
>    I have a PCI-Express based Radeon and would like to get better
> performance. I'm presuming that agpgart support is part of that
> solution? (As it was on earlier architectures?)

I'm pretty sure PCI-Express and AGP are mutually exclusive....


