Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263011AbTFGKvi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 06:51:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263023AbTFGKvi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 06:51:38 -0400
Received: from mrw.demon.co.uk ([194.222.96.226]:8576 "EHLO rebecca")
	by vger.kernel.org with ESMTP id S263011AbTFGKvh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 06:51:37 -0400
Content-Type: text/plain; charset=US-ASCII
From: Mark Watts <m.watts@mrw.demon.co.uk>
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PERC4-DI?
Date: Sat, 7 Jun 2003 12:05:11 +0100
User-Agent: KMail/1.4.3
References: <20030606163717.GK8594@rdlg.net>
In-Reply-To: <20030606163717.GK8594@rdlg.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200306071205.11550.m.watts@mrw.demon.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 Jun 2003 5:37 pm, Robert L. Harris wrote:
> My company is looking at buying some machines with "PERC4-DI" SCSI RAID
> controllers.  Poking around the .config file I'm not finding anything
> related to this.  Anyone know off the top of their heads what driver
> would be used for this controller, any known catastrophic bugs, etc?

If its anything like the PERC 3 cards, it could be anything from an LSI 
through to an Adaptec card. (PERC = PowerEdge Raid Controler).

I haven't found any major issues with any of them yet, but we don't tend to 
push them as hard as others here - we mainly use them in webservers.

Mark.

