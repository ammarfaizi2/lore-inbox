Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129284AbRCBTuj>; Fri, 2 Mar 2001 14:50:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129456AbRCBTu3>; Fri, 2 Mar 2001 14:50:29 -0500
Received: from PO10.ANDREW.CMU.EDU ([128.2.10.110]:33664 "EHLO
	po10.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id <S129284AbRCBTuP>; Fri, 2 Mar 2001 14:50:15 -0500
Message-ID: <0ubzXvpz0001Q6cDsp@andrew.cmu.edu>
Date: Fri,  2 Mar 2001 14:48:11 -0500 (EST)
From: Chaskiel M Grundman <cg2v+@andrew.cmu.edu>
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
Subject: Re: APIC error on CPU0 (UP APIC kernel)
Cc: linux-kernel@vger.kernel.org,
        Mark Hahn <hahn@coffee.psychology.mcmaster.ca>
In-Reply-To: <20010301213248.J3217@conectiva.com.br>
In-Reply-To: <subjzA1z0001Q6c7QE@andrew.cmu.edu>
	<20010301213248.J3217@conectiva.com.br>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from mail: 1-Mar-101 Re: APIC error on CPU0 (UP .. by Arnaldo
C. de Melo@conec 
> can you try 2.4.2-ac8 and tell us the results?
No change (I used 2.4.2-ac9, since that was available...). (The watchdog
doesn't trip and display output, but eventually the errors stop and
rebooting is possible)

> can you run 2.4.2 with noapic?
No change, either on 2.4.2 or 2.4.2-ac9 
