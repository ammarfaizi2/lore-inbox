Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261211AbVCONYP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261211AbVCONYP (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 08:24:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVCONYP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 08:24:15 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:38568 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S261211AbVCONYN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 08:24:13 -0500
Subject: Re: Repeatable IDE Oops for 2.6.11 (ide-scsi vs ide-cdrom)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.GSO.4.62.0503150911540.17649@mion.elka.pw.edu.pl>
References: <20050314065508.GA7974@squish.home.loc>
	 <1110822016.15927.136.camel@localhost.localdomain>
	 <Pine.GSO.4.62.0503150911540.17649@mion.elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1110892926.17740.169.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 15 Mar 2005 13:22:07 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-03-15 at 08:19, Bartlomiej Zolnierkiewicz wrote:
> On Mon, 14 Mar 2005, Alan Cox wrote:
> Locking is fixed in ide-dev-2.6 tree
> (at the moment seem to be dropped from -mm?).

Excellent - I'm looking forward to dropping the -ac IDE locking patches 

