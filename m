Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268268AbUIBMJW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268268AbUIBMJW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:09:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268300AbUIBMJW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:09:22 -0400
Received: from the-village.bc.nu ([81.2.110.252]:2190 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268268AbUIBMHK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:07:10 -0400
Subject: Re: [PATCH] net/ipv4 for Source VIPA support, kernel BK Head
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: lkml@einar-lueck.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200409021401.42255.elueck@de.ibm.com>
References: <200409021401.42255.elueck@de.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1094123102.4996.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 02 Sep 2004 12:05:03 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2004-09-02 at 13:01, Einar Lueck wrote:
> The high-availability requirements drive those customers to ensure that 
> all routes are dynamic which is not possible with the proposed ip route 
> approach.

Why. You are simply doing NAT for that port from all locally sourced
packets to your "virtual" address ? 

Alan

