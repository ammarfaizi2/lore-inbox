Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268860AbUIQPoI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268860AbUIQPoI (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Sep 2004 11:44:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268881AbUIQPm0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Sep 2004 11:42:26 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:27338 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S268860AbUIQPlo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Sep 2004 11:41:44 -0400
Subject: Re: [RFC][PATCH] inotify 0.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Robert Love <rml@novell.com>
Cc: Bill Davidsen <davidsen@tmr.com>, Jan Kara <jack@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1095388176.20763.29.camel@localhost>
References: <Pine.LNX.3.96.1040916182127.20906B-100000@gatekeeper.tmr.com>
	 <1095376979.23385.176.camel@betsy.boston.ximian.com>
	 <1095377752.23913.3.camel@localhost.localdomain>
	 <1095388176.20763.29.camel@localhost>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095431960.26147.13.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 17 Sep 2004 15:39:20 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-09-17 at 03:29, Robert Love wrote:
> I think we want a solution that works well for both cases.

Why does it have to be "a" solution not different things for different
tasks.

> And dnotify utterly falls apart on removable media or for any "large"
> sort of job, e.g. indexing.

Agreed

