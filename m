Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316206AbSEKLYV>; Sat, 11 May 2002 07:24:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316207AbSEKLYU>; Sat, 11 May 2002 07:24:20 -0400
Received: from line103-203.adsl.actcom.co.il ([192.117.103.203]:28932 "HELO
	alhambra.merseine.nu") by vger.kernel.org with SMTP
	id <S316206AbSEKLYT>; Sat, 11 May 2002 07:24:19 -0400
Date: Sat, 11 May 2002 14:20:14 +0300
From: Muli Ben-Yehuda <mulix@actcom.co.il>
To: Christian Neumair <christian-neumair@web.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Re: Re: 3com 3c905cx-tx-nm "unknown device"
Message-ID: <20020511142014.E768@actcom.co.il>
In-Reply-To: <200205111122.g4BBM0X26428@mailgate5.cinetic.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 11, 2002 at 01:22:00PM +0200, Christian Neumair wrote:
> I've had similar struggles in the past with both branded as well as
< noname ethernet-cards. 
> Have you already tried to disable acpi through BIOS?

The BIOS is old enough that it doesn't know anything about ACPI ;)

> If everything fails it's obvious that the card is defect.

That's the assumption I'm proceeding on right now. I'll try to replace
it on Sunday. 

> I'm using a different 905 model without problems at this computer.

I knew these cards are supported, which is why I picked them. FWIW,
when this card failed to perform and a few hours of debugging didn't
turn anything up, I picked up a cheap realtek 8139B, which worked out
of the box.
-- 
The ill-formed Orange
Fails to satisfy the eye:       http://vipe.technion.ac.il/~mulix/
Segmentation fault.             http://syscalltrack.sf.net/
