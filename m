Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965007AbWIDWNa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965007AbWIDWNa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 18:13:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWIDWNa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 18:13:30 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:44775 "EHLO
	pd2mo2so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S965007AbWIDWN3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 18:13:29 -0400
Date: Mon, 04 Sep 2006 16:13:00 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: 2.6.18-rc5-mm1 unusual IRQ number for VIA device
In-reply-to: <fa.2CAUcMm0GNX2+CNwugoJEUNtwzQ@ifi.uio.no>
To: Jay Cliburn <jacliburn@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Message-id: <44FCA4EC.3060507@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <fa.zOFUKsGFxa+fu0uGVN6HuRT+Krg@ifi.uio.no>
 <fa.2CAUcMm0GNX2+CNwugoJEUNtwzQ@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jay Cliburn wrote:
> Jay Cliburn wrote:
>> Running 2.6.18-rc5.mm1 on an Asus M2V mainboard with dual-core Athlon 
>> cpu, the onboard audio device gets assigned and IRQ of 8410.  Under 
>> 2.6.18-rc4-mm3, the same device gets assigned IRQ 17.  Is this a way 
>> to get around this?
> 
> What I meant to ask is:  Is there a way to get around this?
> 
> Thanks,
> Jay

What do you think needs to be "gotten around"? It is using MSI 
interrupts, I think that the IRQ numbers will be different.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

