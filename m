Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261222AbUKMX4b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261222AbUKMX4b (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Nov 2004 18:56:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261221AbUKMX4a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Nov 2004 18:56:30 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:29410 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261220AbUKMX4F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Nov 2004 18:56:05 -0500
Date: Sun, 14 Nov 2004 00:55:57 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Randy.Dunlap" <rddunlap@osdl.org>
cc: "Josef E. Galea" <josefeg@euroweb.net.mt>, linux-kernel@vger.kernel.org
Subject: Re: System call number
In-Reply-To: <41969DAF.3080104@osdl.org>
Message-ID: <Pine.LNX.4.53.0411140055260.22866@yvahk01.tjqt.qr>
References: <41969845.1060803@euroweb.net.mt> <41969DAF.3080104@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Hi,
>
>> Can anyone tell me the system call number for the function
>> write_swap_page() (in kernel/power/pmdisk.c) as I can't find it in
>> unistd.h.

For all others, see linux/arch/<YOURARCH>/kernel/entry.S

>What kernel version?  I don't see what source file in
>2.6.10-rc1-bk23.
>
>There are lots of kernel functions that don't have syscall numbers.
>E.g, write_page() in kernel/power/swsusp.c.



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
