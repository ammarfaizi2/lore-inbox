Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131252AbRAKFnP>; Thu, 11 Jan 2001 00:43:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131201AbRAKFnF>; Thu, 11 Jan 2001 00:43:05 -0500
Received: from mail006.syd.optusnet.com.au ([203.2.75.230]:56769 "EHLO
	mail006.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id <S130436AbRAKFmq>; Thu, 11 Jan 2001 00:42:46 -0500
Message-ID: <3A5D46EA.280692B2@mira.net>
Date: Thu, 11 Jan 2001 16:38:50 +1100
From: Antony Suter <antony@mira.net>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0a19-ac4 i686)
X-Accept-Language: en, fr, de, sv
MIME-Version: 1.0
To: List Linux-Kernel <linux-kernel@vger.kernel.org>
CC: Allen Unueco <allen@premierweb.com>
Subject: Re: Where did vm_operations_struct->unmap in 2.4.0 go?
In-Reply-To: <3A5BD69C.1B2602C6@premierweb.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allen Unueco wrote:
> 
> Sometime around test10 or test11 unmap left vm_operations_struct.  The
> comment implies its there but it's gone.  Where did it go?
> 
> How do I get a call back for a page unmap?
> 
> I ran into this while hacking the Nvidia kernel driver to work with
> 2.4.0.  I got the driver working but it's not 100%
> 
> Also where did get_module_symbol() and put_module_symbol() go?
> 
> -Allen

Patches for the NVIDIA binary X drivers following all these kernel
changes can be gotten from IRC server irc.openprojects.net, channel
#nvidia. Or from http://ex.shafted.com.au/nvidia/

--
- Antony Suter  (antony@mira.net)  "ExWired"  openpgp:71ADFC87
- "...to condense fact from the vapor of nuance."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
