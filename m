Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290613AbSA3VP6>; Wed, 30 Jan 2002 16:15:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290607AbSA3VPl>; Wed, 30 Jan 2002 16:15:41 -0500
Received: from codepoet.org ([166.70.14.212]:13499 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S290606AbSA3VOW>;
	Wed, 30 Jan 2002 16:14:22 -0500
Date: Wed, 30 Jan 2002 14:14:22 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020130211422.GA22705@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0201300110420.1542-100000@penguin.transmeta.com> <E16VrdT-0006t7-00@the-village.bc.nu> <20020130051855.E11267@havoc.gtf.org> <20020130171126.GA26583@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020130171126.GA26583@kroah.com>
User-Agent: Mutt/1.3.24i
X-Operating-System: Linux 2.4.16-rmk1, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed Jan 30, 2002 at 09:11:26AM -0800, Greg KH wrote:
> I have had that same dream too, Jeff :)
> Especially after spelunking through the SCSI drivers, and being amazed
> that only one of them uses the, now two year old, pci_register_driver()
> interface (which means that only that driver works properly in PCI
> hotplug systems.)

Spelunking through the SCSI drivers involves great deal of
bravery.  That pile of dung does not need a "small-stuff"
maintainer.  It needs to be forcefully ejected and replaced with
extreme prejudice.  It is amazing that ancient stuff works as
well as it does...

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
