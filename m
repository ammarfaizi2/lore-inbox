Return-Path: <linux-kernel-owner+w=401wt.eu-S1753185AbWLOSxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185AbWLOSxr (ORCPT <rfc822;w@1wt.eu>);
	Fri, 15 Dec 2006 13:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753190AbWLOSxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Dec 2006 13:53:47 -0500
Received: from smtp.nokia.com ([131.228.20.172]:53254 "EHLO
	mgw-ext13.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753181AbWLOSxq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Dec 2006 13:53:46 -0500
Message-ID: <4582F028.9010308@indt.org.br>
Date: Fri, 15 Dec 2006 14:57:44 -0400
From: Anderson Briglia <anderson.briglia@indt.org.br>
User-Agent: Icedove 1.5.0.8 (X11/20061128)
MIME-Version: 1.0
To: ext Pierre Ossman <drzeus-list@drzeus.cx>
CC: ext Frank Seidel <frank@kernalert.de>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       "Lizardo Anderson (EXT-INdT/Manaus)" <anderson.lizardo@indt.org.br>,
       linux-kernel@vger.kernel.org,
       "Aguiar Carlos (EXT-INdT/Manaus)" <carlos.aguiar@indt.org.br>,
       Tony Lindgren <tony@atomide.com>,
       ext David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/4] Add MMC Password Protection (lock/unlock) support
 V8: mmc_key_retention.diff
References: <20061213155531.1kpbmi3pk40kkoos@webmail.kernalert.de> <45815B3A.1010805@indt.org.br> <4582DA4D.70907@drzeus.cx>
In-Reply-To: <4582DA4D.70907@drzeus.cx>
X-Enigmail-Version: 0.94.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 15 Dec 2006 18:52:58.0478 (UTC) FILETIME=[3CFED0E0:01C7207A]
X-eXpurgate-Category: 1/0
X-eXpurgate-ID: 149371::061215205303-0FC92BB0-0EEFE6CC/0-0/0-1
X-Nokia-AV: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ext Pierre Ossman wrote:
[...]
> Patches look ok, and I'll commit them once you send me this last fix.

Please, see the V9 series version, this bug was fixed there. Once we had some changes on the MMC code, I updated the MMC
PWD code according to the latest mainline code and decided to send another set.

Best Regards,


Anderson Briglia

