Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSCCOn5>; Sun, 3 Mar 2002 09:43:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286647AbSCCOns>; Sun, 3 Mar 2002 09:43:48 -0500
Received: from tele-post-20.mail.demon.net ([194.217.242.20]:49159 "EHLO
	tele-post-20.mail.demon.net") by vger.kernel.org with ESMTP
	id <S286521AbSCCOnl>; Sun, 3 Mar 2002 09:43:41 -0500
Content-Type: text/plain; charset=US-ASCII
From: Stephen Mollett <molletts@yahoo.com>
Organization: Total lack thereof
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Handling of bogus PCI bus numbering - case closed
Date: Sun, 3 Mar 2002 14:44:48 +0000
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16hWZl-0004OG-00@the-village.bc.nu>
In-Reply-To: <E16hWZl-0004OG-00@the-village.bc.nu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16hXDA-0002nr-0K@tele-post-20.mail.demon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 03 Mar 2002 14:02, Alan Cox wrote:
>> The 2.4 PCI subsystem seems not to handle bogus BIOS-assigned PCI bus
>> numbers well...
> Does the pci=assign-busses option help ?

Yes :)

The CardBus gets assigned a real bus number at last.

I must have been so brain-fried when I was scouring the documentation and 
source that I overlooked that one.

Thanks

Stephen
