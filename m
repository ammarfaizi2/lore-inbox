Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262282AbUKQLuJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262282AbUKQLuJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 06:50:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbUKQLuJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 06:50:09 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:6167 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S262282AbUKQLuE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 06:50:04 -0500
Message-ID: <419B3ADC.1040203@tebibyte.org>
Date: Wed, 17 Nov 2004 12:49:48 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: Andrew Morton <akpm@osdl.org>, andrea@novell.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       piggin@cyberone.com.au, riel@redhat.com,
       mmokrejs@ribosome.natur.cuni.cz, tglx@linutronix.de
Subject: Re: [PATCH] fix spurious OOM kills
References: <20041113233740.GA4121@x30.random> <20041114094417.GC29267@logos.cnet> <20041114170339.GB13733@dualathlon.random> <20041114202155.GB2764@logos.cnet> <419A2B3A.80702@tebibyte.org> <419B14F9.7080204@tebibyte.org> <20041117012346.5bfdf7bc.akpm@osdl.org> <20041117060648.GA19107@logos.cnet> <20041117060852.GB19107@logos.cnet> <419B2CFC.7040006@tebibyte.org> <20041117070935.GF19107@logos.cnet>
In-Reply-To: <20041117070935.GF19107@logos.cnet>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Marcelo Tosatti escreveu:
> Please test Andrew's patch, its hopefully good enough for most 
> scenarios. Extreme cases are probably still be problematic.

Will do, though currently testing 2.6.8.1 and it goes without saying 
this is a slow machine.

> What are the "tbtc" patches ? 

Token based thrashing control from Rik van Riel
http://marc.theaimsgroup.com/?l=linux-kernel&m=109122597407401&w=2

Regards,
Chris R.
