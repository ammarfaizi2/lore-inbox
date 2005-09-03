Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751052AbVICV0u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751052AbVICV0u (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Sep 2005 17:26:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751145AbVICV0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Sep 2005 17:26:50 -0400
Received: from quechua.inka.de ([193.197.184.2]:46293 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S1751052AbVICV0u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Sep 2005 17:26:50 -0400
From: Bernd Eckenfels <ecki@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] DSFS Network Forensic File System for Linux Patches
Organization: Private Site running Debian GNU/Linux
In-Reply-To: <1125569702.15768.0.camel@localhost.localdomain>
X-Newsgroups: ka.lists.linux.kernel
User-Agent: tin/1.7.8-20050315 ("Scalpay") (UNIX) (Linux/2.6.8.1 (i686))
Message-Id: <E1EBfWr-0004LP-00@calista.eckenfels.6bone.ka-ip.net>
Date: Sat, 03 Sep 2005 23:26:25 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <1125569702.15768.0.camel@localhost.localdomain> you wrote:
>> The Linux kernel allows binary drivers, you just have to live with a limited
>> number of exported symbols and that the kernel is tainted. Which basically
>> means nobody sane can help you with corrupted kernel data structures.
> 
> You appear to be confused. The exported symbols are part of a GPL
> product. The only question of relevance is whether the item is a derived
> work in law or not. 

I dont understand that? Can you point out where I am confused?

Loading a non-GPL (tagged) module leads in tainting the kernel (which basically
is a flag for developers to be alerted while debugging), is that right?

Non GPL Modules are also restrited in the number of symbols they can use,
this is to make it harder to derive work from the Linux Kernel with a ABI
interface.

Gruss
Bernd
