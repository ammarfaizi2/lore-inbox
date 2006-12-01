Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162066AbWLAWKz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162066AbWLAWKz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 17:10:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162069AbWLAWKz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 17:10:55 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49579 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1162066AbWLAWKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 17:10:54 -0500
Date: Fri, 1 Dec 2006 22:17:45 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Arkadiusz Miskiewicz <arekm@maven.pl>
Cc: Ben Collins <ben.collins@ubuntu.com>, linux-kernel@vger.kernel.org,
       Eric Piel <eric.piel@tremplin-utc>
Subject: Re: [RFC] Include ACPI DSDT from INITRD patch into mainline
Message-ID: <20061201221745.7bea6e72@localhost.localdomain>
In-Reply-To: <200612012301.20086.arekm@maven.pl>
References: <1164998179.5257.953.camel@gullible>
	<1165006694.5257.968.camel@gullible>
	<20061201215551.66b6eb60@localhost.localdomain>
	<200612012301.20086.arekm@maven.pl>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Dec 2006 23:01:20 +0100
Arkadiusz Miskiewicz <arekm@maven.pl> wrote:

> Acer notebook users here dump DSDT from their own machine, fix it and then 
> load via initrd. 

Under EU law thats two copies without permission and modification without
permission of the rights holder....

> > and if they do does it have to be 
> > an ugly hack in the mainstream kernel.
> 
> Can it be done without hacks somehow (in the way that adding fixed DSDT is 
> easy for user)?

Arjan - can you explain the linking dsdt one in more detail ?
