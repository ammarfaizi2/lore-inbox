Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264219AbTFPT7x (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:59:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264221AbTFPT7x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:59:53 -0400
Received: from 200-184-71-82.chies.com.br ([200.184.71.82]:52051 "EHLO
	mars.elipse.com.br") by vger.kernel.org with ESMTP id S264219AbTFPT7w
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:59:52 -0400
Message-ID: <3EEE25C1.5000905@elipse.com.br>
Date: Mon, 16 Jun 2003 17:17:05 -0300
From: Felipe W Damasio <felipewd@elipse.com.br>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021226 Debian/1.2.1-9
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Felipe Wilhelms Damasio <felipe@elipse.com.br>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Rodrigo Gressler <rodrigo@elipse.com.br>
Subject: Re: Geode MediaGX CD-ROM detection problem
References: <D818C01D3A571F49AAB829274DAF9E0402D225@mars.elipse.com.br> <1055545654.6592.6.camel@dhcp22.swansea.linux.org.uk>
In-Reply-To: <1055545654.6592.6.camel@dhcp22.swansea.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Jun 2003 20:17:06.0250 (UTC) FILETIME=[41C732A0:01C33444]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	Hi Alan,

Alan Cox wrote:
> Try booting with the option ide=nodma first of all
> 

	Just tried it. It didn't work.

	I still get "not a valid block device".

	dmesg doesn't tell me anything, either. Just the usual:

CS5530: IDE controller on PCI bus 00 dev 92
.
.
hda: GCR-8521B, ATAPI CD/DVD-ROM drive

	Is there any more info I can provide? Or is there anything else I can 
try?

	Cheers,

Felipe

