Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264061AbUEHDpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264061AbUEHDpy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 May 2004 23:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264085AbUEHDpy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 May 2004 23:45:54 -0400
Received: from gizmo03ps.bigpond.com ([144.140.71.13]:26577 "HELO
	gizmo03ps.bigpond.com") by vger.kernel.org with SMTP
	id S264061AbUEHDpw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 May 2004 23:45:52 -0400
Message-ID: <409C57F3.4010009@techdrive.com.au>
Date: Sat, 08 May 2004 13:45:55 +1000
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
Weird as it no longer crashes my system. Which Kernel are you using? Did 
you turn off the C1Halt patch?

Richard James

