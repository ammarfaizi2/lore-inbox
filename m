Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946127AbWJ0Cve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946127AbWJ0Cve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 22:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946117AbWJ0Cve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 22:51:34 -0400
Received: from [84.77.121.105] ([84.77.121.105]:61641 "EHLO
	merak.nimastelecom.com") by vger.kernel.org with ESMTP
	id S1161471AbWJ0Cvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 22:51:33 -0400
Message-ID: <45417424.2040909@newipnet.com>
Date: Fri, 27 Oct 2006 04:51:16 +0200
From: Carlos Velasco <lkml@newipnet.com>
User-Agent: Thunderbird 1.5.0.7 (Windows/20060909)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: Networking messed up, bad checksum, incorrect length
References: <454166A6.1090905@newipnet.com>
In-Reply-To: <454166A6.1090905@newipnet.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

An Update.

When using kernel 2.6.16.29, I don't see the problem. Packets taken with
tcpdump/libpcap are the real packets.

Linux Merak 2.6.16.29 #1 SMP Fri Oct 27 04:33:56 CEST 2006 x86_64 x86_64
x86_64 GNU/Linux

Regards,
Carlos Velasco
CCNP & CCDP Cisco Certified Network Professional

