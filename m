Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967956AbWLEKZE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967956AbWLEKZE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 05:25:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967724AbWLEKZE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 05:25:04 -0500
Received: from mail.dgt.com.pl ([195.117.141.2]:50068 "EHLO dgt.com.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966969AbWLEKZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 05:25:01 -0500
DGT-Virus-Scanned: amavisd-new at dgt.com.pl
Message-ID: <457548E7.4050702@dgt.com.pl>
Date: Tue, 05 Dec 2006 11:24:39 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
User-Agent: Mozilla/5.0 (X11; U; Linux i686 (x86_64); pl-PL; rv:1.8.0.8) Gecko/20061029 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: skge 2.6.19 UDP checksum error
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have UDP checksum error in TX frames  on my
 "Marvell Technology Group Ltd. 88E8001 Gigabit Ethernet Controller (rev 
13)"

With sk98lin it works fine.


