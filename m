Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267148AbRGKBc7>; Tue, 10 Jul 2001 21:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbRGKBct>; Tue, 10 Jul 2001 21:32:49 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:46097
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S267148AbRGKBce>; Tue, 10 Jul 2001 21:32:34 -0400
Date: Tue, 10 Jul 2001 21:38:30 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: daniel sheltraw <l5gibson@hotmail.com>, linux-kernel@vger.kernel.org
Subject: Re: CardBus and PCI
Message-ID: <20010710213830.A13597@animx.eu.org>
In-Reply-To: <F34guA8M6XQQez1enAq000153a1@hotmail.com> <3B4B6DB8.F26663A1@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <3B4B6DB8.F26663A1@mandrakesoft.com>; from Jeff Garzik on Tue, Jul 10, 2001 at 05:03:52PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > If a CardBus card is in a slot at boot time is it treated as PCI device
> > would be? Is it just another device on another PCI bus?
> 
> In kernel 2.4 and using kernel cardbus support, yes.

But is it possible for it to be configured at boot time (like to use it for
nfsroot)

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
