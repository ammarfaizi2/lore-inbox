Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293122AbSCOSrM>; Fri, 15 Mar 2002 13:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293109AbSCOSrB>; Fri, 15 Mar 2002 13:47:01 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:51982 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S293129AbSCOSqu>; Fri, 15 Mar 2002 13:46:50 -0500
Subject: Re: unwanted disk access by the kernel?
To: dmaas@dcine.com (Dan Maas)
Date: Fri, 15 Mar 2002 19:02:30 +0000 (GMT)
Cc: jerj@coplanar.net (Jeremy Jackson), linux-kernel@vger.kernel.org,
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <005401c1cc51$ab6c3fe0$1a02a8c0@allyourbase> from "Dan Maas" at Mar 15, 2002 01:46:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16lwyE-0004N7-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> By the way, if I enable 'APM makes CPU idle calls when idle,' I get a
> constant stream of 'apm_do_idle failed (3)' messages. APM also doesn't seem
> to be able to power the machine down... This is a Dell Inspiron 7500...
> Maybe I should try ACPI?

ACPI is a bit experimental right now but if you want some fun then obviously
the more people who break the ACPI code the better.

Alan
