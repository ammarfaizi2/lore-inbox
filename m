Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265462AbTFMRx0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 13:53:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265463AbTFMRx0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 13:53:26 -0400
Received: from hermes.cicese.mx ([158.97.1.34]:44968 "EHLO hermes.cicese.mx")
	by vger.kernel.org with ESMTP id S265462AbTFMRxU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 13:53:20 -0400
Message-ID: <3EEA12C0.E15DBAF2@cicese.mx>
Date: Fri, 13 Jun 2003 11:06:56 -0700
From: Serguei Miridonov <mirsev@cicese.mx>
Reply-To: mirsev@cicese.mx
Organization: CICESE Research Center, Ensenada, B.C., Mexico
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: ru, en
MIME-Version: 1.0
To: Damian Kolkowski <deimos@deimos.one.pl>
CC: Grzegorz Jaskiewicz <gj@pointblue.com.pl>, linux-kernel@vger.kernel.org
Subject: Re: via-rhine strange behavior 2.4.21-rc8
References: <200306121227.07122@gjs> <20030613170426.GB573@deimos.one.pl>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Are you sure that ACPI is the reason? Grzegorz Jaskiewicz wrote about generic
2.4.21-rc8 = 2.4.21 which does not have the new ACPI code.

Damian Kolkowski wrote:

> On Thu, Jun 12, 2003 at 12:27:02PM +0100, Grzegorz Jaskiewicz wrote:
> > I attached dmesg from one of my test toys (servers). I am not able to get
> > via-rhine card to work on it :/
>
> Hi I have via-rhine to on my ECS_L7VTA and whenever I use ACPId thet network
> card is not working.
>
> So.., remove ACPI form kernel :-)
>
> > Local APIC disabled by BIOS -- reenabling.
> > Found and enabled local APIC!
>
> Maby if we have some not integrated network card based on via-rhine we could
> heck it why ACPI locks via-rhine; but there in probably no via-rhine outside
> the main bord :-)
>
> --
> # Damian *dEiMoS* Ko³kowski # http://deimos.one.pl/ #
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

--
Serguei Miridonov


