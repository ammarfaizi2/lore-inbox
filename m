Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751392AbVLFL2P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751392AbVLFL2P (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 06:28:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751446AbVLFL2P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 06:28:15 -0500
Received: from mail.gmx.net ([213.165.64.20]:6029 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1751392AbVLFL2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 06:28:15 -0500
X-Authenticated: #428038
Date: Tue, 6 Dec 2005 12:28:12 +0100
From: Matthias Andree <matthias.andree@gmx.de>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051206112812.GG10574@merlin.emma.line.org>
Mail-Followup-To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20051203135608.GJ31395@stusta.de> <43949541.9060700@tmr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43949541.9060700@tmr.com>
X-PGP-Key: http://home.pages.de/~mandree/keys/GPGKEY.asc
User-Agent: Mutt/1.5.11
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 05 Dec 2005, Bill Davidsen wrote:

> If a firm policy of not removing supported features until 2.7 was 
> adopted I don't see a problem. The bulk of the instability (not 

I do - the problem is someone will let it bit-rot for a few releases and
then declare it broken. Remember ATAPI CD writing vs. DMA?

-- 
Matthias Andree
