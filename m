Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293337AbSC0XV3>; Wed, 27 Mar 2002 18:21:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293521AbSC0XVT>; Wed, 27 Mar 2002 18:21:19 -0500
Received: from insgate.stack.nl ([131.155.140.2]:38925 "HELO skynet.stack.nl")
	by vger.kernel.org with SMTP id <S293337AbSC0XVH>;
	Wed, 27 Mar 2002 18:21:07 -0500
Date: Thu, 28 Mar 2002 00:21:01 +0100 (CET)
From: Jos Hulzink <josh@stack.nl>
To: "Pedro M. Rodrigues" <pmanuel@myrealbox.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@suse.cz>,
        Andre Hedrick <andre@linux-ide.org>, Wakko Warner <wakko@animx.eu.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: IDE and hot-swap disk caddies
In-Reply-To: <3CA25A1A.31572.2DCF314@localhost>
Message-ID: <20020328001733.E78593-100000@snail.stack.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Mar 2002, Pedro M. Rodrigues wrote:
>    You can. Acard for instance makes devices for that. They plug at
> the end of an ide cdrom or harddisk, and interface with scsi. They
> have two models, a 20MB/s one, and an UltraWide model that goes
> up to 40MB/s. It has a small risc cpu and you can even upgrade their
> firmware. A friend of mine ordered one to plug a dvd reader in an
> external scsi box he had lying around - he had all his computer drive
> bays used. He said it worked fine and didn't notice any performance
> hit even when playing dvd's.

Indeed you can... But you disconnect from a SCSI bus then, which is in
fact off topic :) I'm willing to assume those devices are hot-pluggable,
but it is not what we want. Besides, I wonder if it isn't cheaper to buy a
decent SCSI device than an IDE device with converter.

Jos

