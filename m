Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274154AbRIXStn>; Mon, 24 Sep 2001 14:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274149AbRIXSte>; Mon, 24 Sep 2001 14:49:34 -0400
Received: from pop.gmx.net ([213.165.64.20]:49335 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S274154AbRIXStW>;
	Mon, 24 Sep 2001 14:49:22 -0400
Date: Mon, 24 Sep 2001 21:00:15 +0200
From: Stefan Fleiter <stefan.fleiter@gmx.de>
To: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.9-ac15
Message-ID: <20010924210015.A1339@shuttle.mothership.home.dhs.org>
Mail-Followup-To: Alan Cox <laughing@shared-source.org>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20010924164143.A11157@lightning.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20010924164143.A11157@lightning.swansea.linux.org.uk>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan!

On Mon, 24 Sep 2001 Alan Cox wrote:


> 2.4.9-ac15

Doing "make modules_install" I get:

depmod: *** Unresolved symbols in
/lib/modules/2.4.9-ac15/kernel/arch/i386/kernel/apm.o
depmod:         __sysrq_unlock_table
depmod:         __sysrq_get_key_op
depmod:         __sysrq_put_key_op
depmod:         __sysrq_lock_table


Greetings,
Stefan
