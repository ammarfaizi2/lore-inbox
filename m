Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264736AbUDWH1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264736AbUDWH1O (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Apr 2004 03:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264738AbUDWH1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Apr 2004 03:27:14 -0400
Received: from koala.ichpw.zabrze.pl ([195.82.164.33]:7691 "EHLO
	koala.ichpw.zabrze.pl") by vger.kernel.org with ESMTP
	id S264736AbUDWH1N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Apr 2004 03:27:13 -0400
Message-ID: <4088C094.2060904@ichpw.zabrze.pl>
Date: Fri, 23 Apr 2004 09:07:00 +0200
From: Marek Mentel <mmark@ichpw.zabrze.pl>
User-Agent: Mozilla Thunderbird 0.5 (X11/20040208)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: kern <linux-kernel@vger.kernel.org>
Subject: __alloc_pages: 0-order allocation failed  - kernel 2.4.24
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 Is this  just out-of-memory situation or  more serious bug ?

Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed (gfp=0x1f0/0)
Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Apr 22 10:42:18 koala kernel: VM: killing process named
Apr 22 10:42:18 koala kernel: __alloc_pages: 0-order allocation failed (gfp=0x1d2/0)
Apr 22 10:42:18 koala kernel: VM: killing process sendmail


