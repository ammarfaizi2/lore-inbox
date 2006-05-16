Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751395AbWEPFeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751395AbWEPFeT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 May 2006 01:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751460AbWEPFeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 May 2006 01:34:19 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:13623 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751395AbWEPFeS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 May 2006 01:34:18 -0400
Date: Mon, 15 May 2006 23:33:35 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [RFT] major libata update
In-reply-to: <6cZvL-4Vb-1@gated-at.bofh.it>
To: Avuton Olrich <avuton@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-id: <4469642F.4040000@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7bit
References: <6cOK9-5WZ-21@gated-at.bofh.it> <6cUPu-6Dh-5@gated-at.bofh.it>
 <6cV8V-71t-3@gated-at.bofh.it> <6cYzI-3yr-3@gated-at.bofh.it>
 <6cYT8-3Vy-7@gated-at.bofh.it> <6cZvL-4Vb-1@gated-at.bofh.it>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avuton Olrich wrote:
> On 5/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> 
>> Can you configure your interrupts so that ethernet and SATA are not on
>> the same irq?
> 
> Sorry, need a little hand holding here. I'm unsure how to do such a
> thing, and can't really google that.

If they are both onboard devices, there is probably no way to do this. 
However, from the lspci output it doesn't appear they are on the same 
IRQ anyway.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

