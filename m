Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131317AbRDBMIu>; Mon, 2 Apr 2001 08:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131348AbRDBMIk>; Mon, 2 Apr 2001 08:08:40 -0400
Received: from eventhorizon.antefacto.net ([193.120.245.3]:63421 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S131317AbRDBMI1>; Mon, 2 Apr 2001 08:08:27 -0400
Message-ID: <3AC8798B.5090302@AnteFacto.com>
Date: Mon, 02 Apr 2001 14:07:23 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Steffen Grunewald <steffen@gfz-potsdam.de>, linux-kernel@vger.kernel.org,
   rsmith@bitworks.com
Subject: Re: Cool Road Runner
In-Reply-To: <Pine.LNX.4.10.10104020046540.12531-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK can we just have a technical discussion?

Andre Hedrick wrote:

> On Mon, 2 Apr 2001, Steffen Grunewald wrote:
> 

[hostilities snipped]

 
> Also, several messages earlier I pointed out that I had not documented the
> feature because it was only attempted once, and only with 2 CFA's in a
> bazar ata-bridge.

1. All compact flash have an inbuilt ATA controller. I.E. they can be
     used exactly like a harddisk, directly off the IDE controller of a 
motherboard.
     I.E. no need for PCMCIA or any of that. I understood from your 
responses
     that you didn't realise this?
2. Compact Flash in this application (I.E. solid state hard disk) is 
getting very
     popular as prices are tumbling.

3. Having a config parameter (uneeded kludge in my opinion), like hdx=flash
     even if hdx is not a compact flash is confusing. Can we call it 
hdx=probe
     which fits nicely with the noprobe option.


> I then explained why the detection was failing and pointed where to verify.

No you didn't. You mentioned a 30 second timeout, but not why it
was caused. Have you seen this yourself or can you point us at who
reported this to you?

 
> After 3-5 attempts and I can not get the point across because the other
> party keeps going off in different directions to do "what about this",

Emm, I think *you* were going off describing your application with
a "bazar ata-bridge", not the simple use of a compact flash as a
hard disk.


> I finally pointed out facts that distrub people, and gave up on trying to
> show/present/give the answer and offered to then enforce their beliefs of
> reality.
> 
> So I state a few facts very pointed to get their attention again and that
> is additude??

Actually I thought the final email was a little more concise/informative, thanks.


[more hostility snipped]

Padraig.

