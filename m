Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264105AbUEHFcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264105AbUEHFcF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 01:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264107AbUEHFcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 01:32:05 -0400
Received: from gizmo01bw.bigpond.com ([144.140.70.11]:59326 "HELO
	gizmo01bw.bigpond.com") by vger.kernel.org with SMTP
	id S264105AbUEHFbz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 01:31:55 -0400
Message-ID: <409C70CC.7040503@techdrive.com.au>
Date: Sat, 08 May 2004 15:31:56 +1000
From: Richard James <richard@techdrive.com.au>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Kumlien <pomac@vapor.com>, linux-kernel@vger.kernel.org
Subject: Re: IO-APIC on nforce2 [PATCH] + [PATCH] for nmi_debug=1 + [PATCH]
References: <1083914992.2797.82.camel@big>
In-Reply-To: <1083914992.2797.82.camel@big>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Kumlien wrote:

>>ASUS have now supplied a BIOS update for the A7N8X-X which fixes the 
>>C1 halt crash. dated the 2004/04/21.  So I assume that they will 
>>supply a patch for all nforce2 motherboards.
>>    
>>
>
>you mean the 1009 bios? It doesn't fix anything.
>I'm using it and:
>
>dmesg output:
>...
>Asus A7N8X-X detected: BIOS IRQ0 pin2 override will be ignored
>...
>PCI: nForce2 C1 Halt Disconnect fixup
>...
>
>(I'm the one that told Len about the new bios that doesn't fix the pin2
>bug and afair, the C1 Halt Disconnect fix checked for flawed values, ie,
>this bios dosn't fix anything...)
>  
>
Actually you are right I just retested it and my system still locks up. 
I must have done something wrong on the origional testing.

My apologies

Richard James

