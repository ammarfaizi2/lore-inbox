Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUEHFdw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUEHFdw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 01:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUEHFdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 01:33:52 -0400
Received: from gizmo09bw.bigpond.com ([144.140.70.19]:24765 "HELO
	gizmo09bw.bigpond.com") by vger.kernel.org with SMTP
	id S264085AbUEHFdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 01:33:44 -0400
Message-ID: <409C7134.6020706@techdrive.com.au>
Date: Sat, 08 May 2004 15:33:40 +1000
From: Richard James <richard@techdrive.com.au>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Richard James <richard@techdrive.com.au>
CC: Jesse Allen <the3dfxdude@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <20040423013039.GA4945@tesore.local> <409B14F1.9090607@techdrive.com.au>
In-Reply-To: <409B14F1.9090607@techdrive.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard James wrote:

> ASUS have now supplied a BIOS update for the A7N8X-X which fixes the 
> C1 halt crash.
> dated the 2004/04/21.  So I assume that they will supply a patch for 
> all nforce2 motherboards.


No this is wrong after retesting with a clean kernel the machine still 
locks up. BIOS 1009 does nothing for us.

Richard James.

