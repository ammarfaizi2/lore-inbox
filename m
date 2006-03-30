Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751020AbWC3M2h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751020AbWC3M2h (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 07:28:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750982AbWC3M2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 07:28:37 -0500
Received: from quechua.inka.de ([193.197.184.2]:46031 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1750711AbWC3M2g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 07:28:36 -0500
From: be-news06@lina.inka.de (Bernd Eckenfels)
To: linux-kernel@vger.kernel.org
Subject: Re: Detecting I/O error and Halting System
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <1143560163.17522.29.camel@localhost.localdomain>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.13.4 (i686))
Message-Id: <E1FOwGQ-00034J-00@calista.inka.de>
Date: Thu, 30 Mar 2006 14:28:34 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> See the softdog driver for an example.

The usermode agent (watchdog(8) can, btw monitor the availableness of a
file, no need to write a module. MAybe this feature was added after somebody
took that code over from you? :)

watchdog.conf(5) says: 

#     file = <filename> Set file name for file mode.  This option can be
#              given as often as you like to check several files.

Bernd
