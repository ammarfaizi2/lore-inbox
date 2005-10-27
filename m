Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932643AbVJ0VcF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932643AbVJ0VcF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Oct 2005 17:32:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932645AbVJ0VcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Oct 2005 17:32:05 -0400
Received: from quechua.inka.de ([193.197.184.2]:29592 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932643AbVJ0VcE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Oct 2005 17:32:04 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 4GB memory and Intel Dual-Core system
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <1130445194.5416.3.camel@blade>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1EVFLu-0006PZ-00@calista.inka.de>
Date: Thu, 27 Oct 2005 23:32:02 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1130445194.5416.3.camel@blade> you wrote:
> I installed 4 x 1 GB DDR2 memory in my Intel Dual-Core 2.80GHz system,
> but it shows me only 3.3 GB of RAM:

What Vendor?

Try a BIOS update, some recent BIOSes support remapping, others dont. Look
in BIOS for remapping settings and also try to change the Video mapping
hole.

Gruss
Bernd
