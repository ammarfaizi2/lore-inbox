Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317165AbSGCSxx>; Wed, 3 Jul 2002 14:53:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317169AbSGCSxx>; Wed, 3 Jul 2002 14:53:53 -0400
Received: from balu.sch.bme.hu ([152.66.208.40]:43710 "EHLO balu.sch.bme.hu")
	by vger.kernel.org with ESMTP id <S317165AbSGCSxv>;
	Wed, 3 Jul 2002 14:53:51 -0400
Date: Wed, 3 Jul 2002 20:56:18 +0200 (MEST)
From: Pozsar Balazs <pozsy@uhulinux.hu>
To: Dominik Brodowski <devel@brodo.de>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HPT370 + ACPI -> freeze (doesn't boot)
In-Reply-To: <20020703192645.B836@brodo.de>
Message-ID: <Pine.GSO.4.30.0207032051340.9693-100000@balu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

I tried
  2.4.18 + acpi-20020611
and
  2.4.18 + acpi-20020611 + pciirq-27

but both of them freeze the same way :(.


I noticed that it is not an immediate freeze though. alt-sysrq-T works for
about 5 seconds... after that, nothing.


If you do think the call traces would do help, I might take time to do
write them down.


On Wed, 3 Jul 2002, Dominik Brodowski wrote:

> Hi,
>
> On Tue, Jul 02, 2002 at 08:33:32AM +0200, Pozsar Balazs wrote:
> >
> > I tried 2.4.18-pre8 + acpi-20020503 + pciirq-18 and the same freeze :(
> pciirq-18 is buggy, unfortunately. Could you please get the latest
> acpi-patch from
> http://www.sourceforge.net/projects/acpi/ ?
> Thanks.
>
> Dominik
>

-- 
pozsy

