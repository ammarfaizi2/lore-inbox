Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262245AbVCOEr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262245AbVCOEr6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 23:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262246AbVCOEr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 23:47:57 -0500
Received: from quechua.inka.de ([193.197.184.2]:16062 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S262245AbVCOEr4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 23:47:56 -0500
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Devices/Partitions over 2TB
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <42362527.6010005@utah-nac.org>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.6-20040906 ("Baleshare") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1DB3yF-0002BK-00@calista.eckenfels.6bone.ka-ip.net>
Date: Tue, 15 Mar 2005 05:47:55 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <42362527.6010005@utah-nac.org> you wrote:
> You have to ignore the partition table contents for ending cylinder.

Why use MSDOS partition tables at all? What about LVM or GUID Partitions?

Gruss
Bernd
