Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293175AbSC0Wsf>; Wed, 27 Mar 2002 17:48:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293159AbSC0Ws0>; Wed, 27 Mar 2002 17:48:26 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:17757 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S293129AbSC0WsO>; Wed, 27 Mar 2002 17:48:14 -0500
From: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>
Date: Wed, 27 Mar 2002 23:47:38 +0100
MIME-Version: 1.0
Subject: Re: IDE and hot-swap disk caddies
CC: Pavel Machek <pavel@suse.cz>, Andre Hedrick <andre@linux-ide.org>,
        Wakko Warner <wakko@animx.eu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Message-ID: <3CA25A1A.31572.2DCF314@localhost>
In-Reply-To: <20020327222900.GO19837@atrey.karlin.mff.cuni.cz>
X-mailer: Pegasus Mail for Windows (v4.01)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


   You can. Acard for instance makes devices for that. They plug at 
the end of an ide cdrom or harddisk, and interface with scsi. They 
have two models, a 20MB/s one, and an UltraWide model that goes 
up to 40MB/s. It has a small risc cpu and you can even upgrade their 
firmware. A friend of mine ordered one to plug a dvd reader in an 
external scsi box he had lying around - he had all his computer drive 
bays used. He said it worked fine and didn't notice any performance 
hit even when playing dvd's.


/Pedro

On 27 Mar 2002 at 23:29, Pavel Machek wrote:

> I have seen USB mass storage devices with ide connector on them, so it
> is certainly possible to translate between scsi and ide. If it makes
> sense from performance standpoint.... I don't know.
>       Pavel
> 

