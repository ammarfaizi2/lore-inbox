Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162057AbWLAWCA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162057AbWLAWCA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:02:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162059AbWLAWCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:02:00 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:29312 "EHLO
	outgoing1.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1162057AbWLAWB7 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:01:59 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Alan <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
Date: Fri, 1 Dec 2006 23:01:20 +0100
User-Agent: KMail/1.9.5
Cc: Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
References: <1164998179.5257.953.camel@gullible> <1165006694.5257.968.camel@gullible> <20061201215551.66b6eb60@localhost.localdomain>
In-Reply-To: <20061201215551.66b6eb60@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612012301.20086.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 01 December 2006 22:55, Alan wrote:
> > > Does that change the fact it is ugly ?
> >
> > No, but it does beg the question "how else can it be done"?
>
> Agreed.

So how else can it be done?

> > Distros need a way for users to add a fixed DSDT without recompiling
> > their own kernels.
>
> Legal rights to do so aside, do they ? 

Acer notebook users here dump DSDT from their own machine, fix it and then 
load via initrd. No legal problems. (... and without that even battery can't 
be monitored on sych notebooks)

> and if they do does it have to be 
> an ugly hack in the mainstream kernel.

Can it be done without hacks somehow (in the way that adding fixed DSDT is 
easy for user)?

> Alan

-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
