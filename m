Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVGSK2r@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVGSK2r (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 06:28:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261949AbVGSK2r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 06:28:47 -0400
Received: from alpha.tmit.bme.hu ([152.66.246.10]:50192 "EHLO alpha.ttt.bme.hu")
	by vger.kernel.org with ESMTP id S261948AbVGSK2r (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 06:28:47 -0400
Message-ID: <42DD54A7.1070703@alpha.tmit.bme.hu>
Date: Tue, 19 Jul 2005 12:29:43 -0700
From: Gyorgy Horvath <horvaath@alpha.tmit.bme.hu>
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: ANNOUNCE: Driver for Rocky 4782E WDT and pls help
References: <42DC2871.1030103@alpha.tmit.bme.hu>	 <1121704467.12438.71.camel@localhost.localdomain>	 <42DD3CD3.9070508@alpha.tmit.bme.hu> <1121764841.22336.14.camel@localhost.localdomain>
In-Reply-To: <1121764841.22336.14.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>There are not, but I've seen various boxes behave the way you describe
>with IDE DMA enabled as IDE DMA uses a lot of the PCI bandwidth. Usually
>it indicates a hardware bug and as far as ICH errata are concerned I
>know of none relevant. You can check however as Intel put most chipset
>errata docs on their website.
>  
>
Thank you for your help.
Now I temporarily put the box back to the fields with IDE-DMA disabled.

Thought I rememeber IDE busmastering prefers very long bursts in contrast to
my very short but high-rate bursts. This can lead it into trouble...
Anyway,  I'm going after and report back if I found something.

Best regards,

Gyuri

