Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263285AbTIGOy7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Sep 2003 10:54:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263295AbTIGOy7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Sep 2003 10:54:59 -0400
Received: from lidskialf.net ([62.3.233.115]:52430 "EHLO beyond.lidskialf.net")
	by vger.kernel.org with ESMTP id S263285AbTIGOy7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Sep 2003 10:54:59 -0400
From: Andrew de Quincey <adq_dvb@lidskialf.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [ACPI] [PATCH] 2.6.0-test4 ACPI fixes series (4/4)
Date: Sun, 7 Sep 2003 15:54:57 +0100
User-Agent: KMail/1.5.3
Cc: Jeff Garzik <jgarzik@pobox.com>, torvalds@osdl.org,
       lkml <linux-kernel@vger.kernel.org>, acpi-devel@lists.sourceforge.net,
       linux-acpi@intel.com
References: <200309051958.02818.adq_dvb@lidskialf.net> <200309060157.47121.adq_dvb@lidskialf.net> <1062863230.2795.1.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062863230.2795.1.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200309071554.57500.adq_dvb@lidskialf.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 06 September 2003 16:47, Alan Cox wrote:
> On Sad, 2003-09-06 at 01:57, Andrew de Quincey wrote:
> > This patch removes some erroneous code from mpparse which breaks IO-APIC
> > programming
>
> These shouldnt be removed but checked against the arch being an E7000,
> which does need this.

Should that code be added back into 2.4.23-pre3? 

