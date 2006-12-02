Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424269AbWLBRfS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424269AbWLBRfS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Dec 2006 12:35:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424270AbWLBRfS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Dec 2006 12:35:18 -0500
Received: from outgoing1.smtp.agnat.pl ([193.239.44.83]:60051 "EHLO
	outgoing1.smtp.agnat.pl") by vger.kernel.org with ESMTP
	id S1424269AbWLBRfQ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Dec 2006 12:35:16 -0500
From: Arkadiusz Miskiewicz <arekm@maven.pl>
Organization: SelfOrganizing
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: Acer smart battery (was Re: [RFC] Include ACPI DSDT from INITRD patch into mainline)
Date: Sat, 2 Dec 2006 18:34:59 +0100
User-Agent: KMail/1.9.5
Cc: linux-kernel@vger.kernel.org
References: <1164998179.5257.953.camel@gullible> <200612012301.20086.arekm@maven.pl> <20061202125004.GA4773@ucw.cz>
In-Reply-To: <20061202125004.GA4773@ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200612021834.59840.arekm@maven.pl>
X-Authenticated-Id: arekm
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 02 December 2006 13:50, Pavel Machek wrote:

> > Acer notebook users here dump DSDT from their own machine, fix it and
> > then load via initrd. No legal problems. (... and without that even
> > battery can't be monitored on sych notebooks)
>
> Merge smart battery support, instead of hacking DSDT. It is about time
> linux started supporting smart batteries, and yes they are documented.
Are you talking about this?
https://sourceforge.net/forum/forum.php?forum_id=604605

It's seem to be already merged and I didn't even know about that feature.
-- 
Arkadiusz Mi¶kiewicz        PLD/Linux Team
arekm / maven.pl            http://ftp.pld-linux.org/
