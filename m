Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287134AbSCCOqD>; Sun, 3 Mar 2002 09:46:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286825AbSCCOpr>; Sun, 3 Mar 2002 09:45:47 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:65290 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S286647AbSCCOpn>; Sun, 3 Mar 2002 09:45:43 -0500
Subject: Re: Handling of bogus PCI bus numbering - case closed
To: molletts@yahoo.com (Stephen Mollett)
Date: Sun, 3 Mar 2002 15:00:42 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org
In-Reply-To: <E16hXDA-0002nr-0K@tele-post-20.mail.demon.net> from "Stephen Mollett" at Mar 03, 2002 02:44:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16hXTe-0004WX-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> numbers well...
> > Does the pci=assign-busses option help ?
> 
> Yes :)
> The CardBus gets assigned a real bus number at last.
> 
> I must have been so brain-fried when I was scouring the documentation and 
> source that I overlooked that one.

Its not terribly well documented. Can you run dmidecode on your laptop
and hopefully we can catch that laptop and automtically do bus assignment
for it
