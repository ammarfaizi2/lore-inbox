Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbVA0Vkx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbVA0Vkx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 16:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261204AbVA0Vkw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 16:40:52 -0500
Received: from mail.charite.de ([160.45.207.131]:41158 "EHLO mail.charite.de")
	by vger.kernel.org with ESMTP id S261188AbVA0Vj7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 16:39:59 -0500
Date: Thu, 27 Jan 2005 22:39:57 +0100
From: Ralf Hildebrandt <Ralf.Hildebrandt@charite.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Re:parport disabled?
Message-ID: <20050127213957.GE23534@charite.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20050127150306.GA29334@linux.ensimag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050127150306.GA29334@linux.ensimag.fr>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* castet.matthieu@free.fr <castet.matthieu@free.fr>:

> > Whenever I "modprobe parport_pc", I get this message:
> > 
> > Jan 27 10:55:47 hummus kernel: pnp: Device 00:0b activated.
> > Jan 27 10:55:47 hummus kernel: parport: PnPBIOS parport detected.
> > Jan 27 10:55:47 hummus kernel: pnp: Device 00:0b disabled.
> > 
> > and the parallel port is unusable ever after.
> > This is with Kernel 2.6.10-ac10 and 2.6.10-ac11
> > 
> > How can I make my parallel port usable again?

> Try disabling acpi.

Didn't help. Same symptom

-- 
Ralf Hildebrandt (i.A. des IT-Zentrum)          Ralf.Hildebrandt@charite.de
Charite - Universitätsmedizin Berlin            Tel.  +49 (0)30-450 570-155
Gemeinsame Einrichtung von FU- und HU-Berlin    Fax.  +49 (0)30-450 570-962
IT-Zentrum Standort CBF                 send no mail to spamtrap@charite.de
