Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVA2Mcu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVA2Mcu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 07:32:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262906AbVA2Mcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 07:32:50 -0500
Received: from quechua.inka.de ([193.197.184.2]:37277 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262905AbVA2Mct (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 07:32:49 -0500
From: Bernd Eckenfels <ecki-news2005-01@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug 4081] New: OpenOffice crashes while starting due to a   threading error
Organization: Deban GNU/Linux Homesite
In-Reply-To: <pan.2005.01.29.10.44.08.856000@surrey.ac.uk>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1CurmR-0000H8-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 29 Jan 2005 13:32:47 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <pan.2005.01.29.10.44.08.856000@surrey.ac.uk> you wrote:
> stat64("/dev/dri/card14", 0xbff9c8bc)   = -1 ENOENT (No such file or directory)

> What is at fault? Certainly oo shouldn't just seg-fault, but should the
> permissions on /dev/dri/card* be crw-rw---- or crw-rw-rw-?

it is not a permission thing, it tells you, that you have not card14 - and i
dont know the dri interface but it looks unlikely that there ever will be
one .)

Greetings
Bernd
