Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751185AbWDSTgN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751185AbWDSTgN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Apr 2006 15:36:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751196AbWDSTgM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Apr 2006 15:36:12 -0400
Received: from mail.protest.com.pl ([213.241.45.210]:1503 "EHLO
	mail.protest.com.pl") by vger.kernel.org with ESMTP
	id S1751185AbWDSTgL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Apr 2006 15:36:11 -0400
Date: Wed, 19 Apr 2006 21:36:09 +0200 (CEST)
From: =?iso-8859-2?Q?Pawe=B3_Kowalski?= <pk@protest.com.pl>
To: linux-kernel@vger.kernel.org
Subject: problem with cache size
Message-ID: <Pine.LNX.4.58.0604192134240.9362@filer.protest.com.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
I'm using RedHat Linux 7.2 with compiled kernel 2.4.25.
My serwer has one cpu "Intel(R) Pentium(R) 4 CPU 3.20GHz" with HT flag so
there are two processors in cpuinfo.
The processor has 2MB cache but `cat /proc/cpuinfo` shows only 16KB.
When I try to use 2.4.17 kernel, there is 2048KB cache but cpuinfo shows
only one cpu :)
I don't know where I should send my question, maybe You could help me.
I'll be very thankful for any answer.

Best Regards,

---
Pawel Kowalski


---
pk
