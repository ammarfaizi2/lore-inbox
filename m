Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270724AbTGNShI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 14:37:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270725AbTGNShI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 14:37:08 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:51395
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S270724AbTGNShE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 14:37:04 -0400
Subject: Re: IDE/Promise 20276 FastTrack RAID Doesn't work in 2.4.21,
	patchattached to fix
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Samuel Flory <sflory@rackable.com>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Ruth.Ivimey-Cook@ivimey.org,
       Chad Kitching <CKitching@powerlandcomputers.com>,
       Steven Dake <sdake@mvista.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F12E8F0.5020107@rackable.com>
References: <Pine.SOL.4.30.0307121754050.19333-100000@mion.elka.pw.edu.pl>
	 <200307121801.03776.ruth@ivimey.org>  <3F12E8F0.5020107@rackable.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1058208541.561.108.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 14 Jul 2003 19:49:02 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>   Yes unless you insert the pdcraid module.  Linux will only see the raw 
> drives.  Once you insert pdcraid you can see the raid devices, and raw 
> disks.  Which can cause major issues at times.

You need to be able to see both for some situations - eg maintainability

