Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270239AbTG1QJq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 12:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270248AbTG1QJq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 12:09:46 -0400
Received: from mail.gmx.net ([213.165.64.20]:37051 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S270239AbTG1QJp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 12:09:45 -0400
Message-ID: <3F254E5F.8040700@gmx.de>
Date: Mon, 28 Jul 2003 18:25:03 +0200
From: Alexander Rau <al.rau@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030715
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, Andrew de Quincey <adq_dvb@lidskialf.net>
Subject: Re: [PATCH] ACPI patch which fixes all my IRQ problems on nforce2
 -- linux-2.5.75-acpi-irqparams-final4.patch
References: <200307272305.12412.adq_dvb@lidskialf.net> <200307281638.24474.adq_dvb@lidskialf.net> <3F2546EF.9030803@gmx.de> <200307281653.58216.adq_dvb@lidskialf.net>
In-Reply-To: <200307281653.58216.adq_dvb@lidskialf.net>
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew de Quincey wrote:
> On Monday 28 July 2003 16:53, you wrote:
> 
>>Andrew de Quincey wrote:
>>
>>>Weird! I compiled it on 2.6.0-test2 last night (for a thinkpad T20), and
>>>it was fine..... (and the thinkpad works fine too)
>>>
>>>Send me your .config file so I can fix the patch, please.
>>>
>>Hope this solved the problems on my T40p too :)
> 
> 
> Ta, lemme know how it goes.
> 
> 

Sorry, there's still a kernel oops during bootup. I'll provide a kernel 
trace when I'm back at home.

Regards, Al


