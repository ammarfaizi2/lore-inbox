Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262974AbUEGErx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262974AbUEGErx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 00:47:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262996AbUEGErw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 00:47:52 -0400
Received: from gizmo08bw.bigpond.com ([144.140.70.18]:34008 "HELO
	gizmo08bw.bigpond.com") by vger.kernel.org with SMTP
	id S262974AbUEGErv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 00:47:51 -0400
Message-ID: <409B14F1.9090607@techdrive.com.au>
Date: Fri, 07 May 2004 14:47:45 +1000
From: Richard James <richard@techdrive.com.au>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Allen <the3dfxdude@hotmail.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
 for idle=C1halt, 2.6.5
References: <20040423013039.GA4945@tesore.local>
In-Reply-To: <20040423013039.GA4945@tesore.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Allen wrote:

>Len Brown wrote:
>  
>
>>Have you been able to hang the AN35N under any conditions?
>>Old BIOS, non-vanilla kernel?
>>    
>>
>
>Yes, and I described that it will hang under the pre-Dec 5th BIOS in another 
>mail.
>
>I still have images of the buggy BIOS, and the fixed one on my hard drive.
>They are also available at ftp://ftp.shuttle.com/BIOS/an35_n/ as
>an35s00j.bin (Oct 2003)
>an35s00l.bin (Dec 5th 2003)
>
>  
>
ASUS have now supplied a BIOS update for the A7N8X-X which fixes the C1 
halt crash.
dated the 2004/04/21.  So I assume that they will supply a patch for all 
nforce2 motherboards.

Richard James

