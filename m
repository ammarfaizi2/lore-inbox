Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261303AbTCOCV5>; Fri, 14 Mar 2003 21:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261304AbTCOCV5>; Fri, 14 Mar 2003 21:21:57 -0500
Received: from lucidpixels.com ([66.45.37.187]:64267 "HELO lucidpixels.com")
	by vger.kernel.org with SMTP id <S261303AbTCOCV4>;
	Fri, 14 Mar 2003 21:21:56 -0500
Date: 15 Mar 2003 02:32:44 -0000
Message-ID: <20030315023244.3013.qmail@lucidpixels.com>
From: war@lucidpixels.com
To: linux-kernel@vger.kernel.org
Subject: Broadcom BCM5702 Major Problems
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When compiled in statically it does not work.
Loading the module after the entire system loads, then ifconfigging works ok.
Hm, maybe PCI sharing must be turned off, I read this from somewhere on google?
I am also running latest stable kernel 2.4.21-pre5-7.
