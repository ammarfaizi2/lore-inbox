Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423774AbWJaSi1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423774AbWJaSi1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 13:38:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423778AbWJaSi1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 13:38:27 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.142]:6621 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1423774AbWJaSi0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 13:38:26 -0500
Message-ID: <4547981F.6040006@us.ibm.com>
Date: Tue, 31 Oct 2006 10:38:23 -0800
From: "Darrick J. Wong" <djwong@us.ibm.com>
Reply-To: "Darrick J. Wong" <djwong@us.ibm.com>
Organization: IBM LTC
User-Agent: Thunderbird 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: Muli Ben-Yehuda <muli@il.ibm.com>
CC: linux-scsi <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alexis Bruemmer <alexisb@us.ibm.com>
Subject: Re: [PATCH] 0/3: Fix EH problems in libsas and implement more error
 handling
References: <45468845.20400@us.ibm.com> <20061031105452.GD28239@rhun.haifa.ibm.com> <454791A5.9000202@us.ibm.com> <20061031183239.GE4698@rhun.ibm.com>
In-Reply-To: <20061031183239.GE4698@rhun.ibm.com>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Muli Ben-Yehuda wrote:

> Ok, I'll re-run with printk timestamps.

Thanks!

> Pointers to the updated firmware and how to update it?

http://www-307.ibm.com/pc/support/site.wss/document.do?sitestyle=ibm&lndocid=MIGR-62832

Download ISO, burn ISO to CD, boot system off CD, run gross-looking DOS
based EGA gooey (and I mean gooey!) update program, reboot.

--D
