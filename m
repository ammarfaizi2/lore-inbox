Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262127AbTKHUXk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 15:23:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262128AbTKHUXk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 15:23:40 -0500
Received: from pop.gmx.de ([213.165.64.20]:12254 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262127AbTKHUXj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 15:23:39 -0500
X-Authenticated: #15936885
Message-ID: <3FAD50CA.3080507@gmx.net>
Date: Sat, 08 Nov 2003 21:23:38 +0100
From: Carl-Daniel Hailfinger <c-d.hailfinger.kernel.2003@gmx.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030821
X-Accept-Language: de, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Manfred Spraul <manfred@colorfullife.com>,
       Andrew de Quincey <adq@lidskialf.net>
Subject: Re: [PATCH 2.4] forcedeth
References: <3FAC837F.2070601@gmx.net> <20031108085415.C18856@infradead.org> <3FAD2E04.3020800@pobox.com>
In-Reply-To: <3FAD2E04.3020800@pobox.com>
X-Enigmail-Version: 0.76.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> Christoph Hellwig wrote:
> 
>> On Sat, Nov 08, 2003 at 06:47:43AM +0100, Carl-Daniel Hailfinger wrote:
>>
>>> Attached is forcedeth: A new driver for the ethernet interface of the
>>> NVIDIA nForce chipset, licensed under GPL.
>>
>>
>> Any chance to give the driver a more descriptive name, say nforce_eth?
>> Traditionally we tend to name like drivers after the hardware's name or
>> codename, not the development methology used.
> 
> 
> I agree with you on this -- but -- in this special case, it seems wise
> to avoid using a potential trademark as a filename...
> 
> I would prefer to avoid the issue completely, rather have to chase down
> some lawyers and get a definitive answer.

We (Manfred, Andrew and I) debated the name for quite a long time and
forcedeth, forced and forceeth were the final candidates. forcedeth was
not only a descriptive name, but also a clever pun. So it won the compo.


Carl-Daniel

