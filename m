Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261386AbVFDPbK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261386AbVFDPbK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 11:31:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbVFDPbK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 11:31:10 -0400
Received: from quechua.inka.de ([193.197.184.2]:56714 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S261386AbVFDPbI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 11:31:08 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux does not care for data integrity
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <42A1AE8B.5000907@tmr.com>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1Deac5-0008KA-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 04 Jun 2005 17:31:05 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <42A1AE8B.5000907@tmr.com> you wrote:
> I thought apcuspd was a third party project, sourceforce shows it as a 
> project. Didn't know APC was actually "providing" anything, is the 
> driver on the CD now? Sure wasn't on the APC CD I had, I did have it at 
> one time, but it didn't come with the UPS (at that time).

And I havent found a UPS Daemon yet who can out of the box query the snmp
cards, one has to hack that themself. However this is still no option
against data corruption on power loss. I mean: there is a fuse in your
Server. And UPS are known to fail even with power attached.

Gruss
Bernd
