Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965147AbVKVTjI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965147AbVKVTjI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 14:39:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965148AbVKVTjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 14:39:08 -0500
Received: from gateway.argo.co.il ([194.90.79.130]:262 "EHLO argo2k.argo.co.il")
	by vger.kernel.org with ESMTP id S965147AbVKVTjG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 14:39:06 -0500
Message-ID: <438373D6.9020902@argo.co.il>
Date: Tue, 22 Nov 2005 21:39:02 +0200
From: Avi Kivity <avi@argo.co.il>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Brian Gerst <bgerst@didntduck.org>
CC: Jeff Garzik <jgarzik@pobox.com>, Jon Smirl <jonsmirl@gmail.com>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Dave Airlie <airlied@gmail.com>,
       Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Small PCI core patch
References: <1132616132.26560.62.camel@gaston> <21d7e9970511211647r4df761a2l287715368bf89eb6@mail.gmail.com> <1132623268.20233.14.camel@localhost.localdomain> <1132626478.26560.104.camel@gaston> <9e4733910511211923r69cdb835pf272ac745ae24ed7@mail.gmail.com> <43833D61.9050400@argo.co.il> <20051122155143.GA30880@havoc.gtf.org> <43834400.3040506@argo.co.il> <20051122162506.GA32684@havoc.gtf.org> <438349F4.2080405@argo.co.il> <20051122165638.GE32684@havoc.gtf.org> <43835772.9070204@didntduck.org>
In-Reply-To: <43835772.9070204@didntduck.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Nov 2005 19:39:05.0107 (UTC) FILETIME=[65C1E630:01C5EF9C]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst wrote:

> The biggest problem with VIA (and Intel) is that they are only 
> available as integrated video on the motherboard.  I can't just walk 
> to the store and pick one up off the shelf.  I have yet to see any 
> AMD64 motherboards with these chipsets either.

Actually I have a via/amd board:

00:00.1 Host bridge: VIA Technologies, Inc. K8M800 Host Bridge
00:01.0 PCI bridge: VIA Technologies, Inc. VT8237 PCI bridge 
[K8T800/K8T890 South]
01:00.0 VGA compatible controller: VIA Technologies, Inc. S3 Unichrome 
Pro VGA Adapter (rev 01)

Works well on FC4 with an Ubuntu driver.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

