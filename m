Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266179AbRF2UpC>; Fri, 29 Jun 2001 16:45:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266180AbRF2Uow>; Fri, 29 Jun 2001 16:44:52 -0400
Received: from pizda.ninka.net ([216.101.162.242]:42150 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S266179AbRF2Uok>;
	Fri, 29 Jun 2001 16:44:40 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15164.59568.527480.216539@pizda.ninka.net>
Date: Fri, 29 Jun 2001 13:44:32 -0700 (PDT)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: christophe.barbe@lineo.fr (christophe barbi), linux-kernel@vger.kernel.org
Subject: Re: Qlogic Fiber Channel
In-Reply-To: <E15Fzu8-0000SK-00@the-village.bc.nu>
In-Reply-To: <20010629151910.C27847@pc8.lineo.fr>
	<E15Fzu8-0000SK-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > > =46rom my point of view, this driver is sadly broken. The fun part is t=
 > > hat
 > > the qlogic driver is certainly based on this one too (look at the code,=
 > >  the
 > > drivers differs not so much).=20
 > 
 > And if the other one is stable someone should spend the time merging the
 > two.

Actually, I think "sadly broken" depends upon your situation.
I've been using the driver just fine on my systems here, even
during cerberus stress testing.  So it is working perfectly fine
for some people.

Later,
David S. Miller
davem@redhat.com
