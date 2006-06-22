Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751826AbWFVRQa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbWFVRQa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jun 2006 13:16:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751837AbWFVRQa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jun 2006 13:16:30 -0400
Received: from quechua.inka.de ([193.197.184.2]:3557 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751826AbWFVRQa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jun 2006 13:16:30 -0400
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Measuring tools - top and interrupts
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <20060622091958.ac824e60.rdunlap@xenotime.net>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FtSn5-0007Vb-00@calista.eckenfels.net>
Date: Thu, 22 Jun 2006 19:16:27 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Randy.Dunlap <rdunlap@xenotime.net> wrote:
>> Is there something that shows the current
>> interrupts/second in LINUX (such as systat in
>> 'BSD)?
> 
> You can use/modify http://www.xenotime.net/linux/scripts/sysalive.pl
> for interrupts/second (it already does that).

vmstat shoes a "in" column, and mpstat shows multiple interrupt related
numbers.

Gruss
Bernd
