Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315627AbSFAVnv>; Sat, 1 Jun 2002 17:43:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316719AbSFAVnu>; Sat, 1 Jun 2002 17:43:50 -0400
Received: from 205-158-62-105.outblaze.com ([205.158.62.105]:42678 "HELO
	ws4-4.us4.outblaze.com") by vger.kernel.org with SMTP
	id <S315627AbSFAVnu>; Sat, 1 Jun 2002 17:43:50 -0400
Message-ID: <20020601214345.4502.qmail@linuxmail.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
X-Mailer: MIME-tools 5.41 (Entity 5.404)
From: "Anthony Spinillo" <tspinillo@linuxmail.org>
To: linux-kernel@vger.kernel.org
Date: Sun, 02 Jun 2002 05:43:45 +0800
Subject: Re: INTEL 845G Chipset IDE Quandry
X-Originating-Ip: 24.49.78.239
X-Originating-Server: ws4-4.us4.outblaze.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That is a relief. ;) Thanks Andre. 

Tony
> 
> 
> I need to add "24cb" to the list of hosts.
> 
> On Sat, 1 Jun 2002, Anthony Spinillo wrote:
> 
> > I am having trouble enabling DMA on a recently
> > installed motherboard. (Intel D845GBVL - 845g chipset). I am running a fresh RedHat7.3 install 
> > and have tried the stock RH kernel, and I'm up to 2.4.19-pre9. I have a CD burner and DVD drive 
> > attached which operated with DMA on an older 
> > 845 mobo. If I run hdparm -d1 /dev/hd(a or c),
> > I now get:
> > 
> > HDIO_SET_DMA failed: Operation not permitted
> > 
> > Here is a snippet from dmesg:
> > 

-- 
Get your free email from www.linuxmail.org 


Powered by Outblaze
