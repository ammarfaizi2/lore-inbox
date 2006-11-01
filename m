Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946904AbWKAO1P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946904AbWKAO1P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 09:27:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946903AbWKAO1P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 09:27:15 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:24728 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946904AbWKAO1P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 09:27:15 -0500
Subject: Re: ASUS M2NPV-VM APIC/ACPI Bug (patched)
From: Arjan van de Ven <arjan@infradead.org>
To: impulze <impulze@impulze.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andi Kleen <ak@suse.de>,
       Allen Martin <AMartin@nvidia.com>, Robert Hancock <hancockr@shaw.ca>,
       Len Brown <lenb@kernel.org>, Andy Currid <ACurrid@nvidia.com>
In-Reply-To: <4548AD4E.8050007@impulze.org>
References: <DBFABB80F7FD3143A911F9E6CFD477B00E48D31D@hqemmail02.nvidia.com>
	 <200610201504.51657.ak@suse.de>  <4548AD4E.8050007@impulze.org>
Content-Type: text/plain
Organization: Intel International BV
Date: Wed, 01 Nov 2006 15:27:08 +0100
Message-Id: <1162391232.23744.21.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Anyway i chatted around the globus and someone also mentioned that my 
> IRQs for sound and several others are very high. I'm not sure if this is 
> a board issue or a kernel issue. But since the sound chip on board (hda 
> intel) is having problems too I guess it's a kernel related thing. I 
> wonder if this will be fixed in newer versions.

btw if you have bios problems you can always use the linux-ready
firmware developer kit to test how well it does; see
http://www.linuxfirmwarekit.org for details

-- 
if you want to mail me at work (you don't), use arjan (at) linux.intel.com
Test the interaction between Linux and your BIOS via http://www.linuxfirmwarekit.org

