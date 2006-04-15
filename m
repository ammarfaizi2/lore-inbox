Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751263AbWDOTLz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751263AbWDOTLz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 15:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbWDOTLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 15:11:55 -0400
Received: from miggins.aqhostdns.com ([216.93.243.2]:59814 "EHLO
	miggins.aqhostdns.com") by vger.kernel.org with ESMTP
	id S1751263AbWDOTLy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 15:11:54 -0400
Subject: A puzzle: CAPZLOQ TEKNIQ 1.0
From: Joe Barr <joe@pjprimer.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Sat, 15 Apr 2006 14:13:14 -0500
Message-Id: <1145128394.19148.9.camel@wartslair.lan>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
X-Antivirus-Scanner: Scanned and found to be clean by AQHost - http://www.AQHost.com
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - miggins.aqhostdns.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - pjprimer.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The cross-platform viral proof-of-concept in the news last week does
indeed infect both Windows and Linux ELF binaries.  At least it does on
some kernels.  Some tests show it doesn't work on the latest versions.

Hans-Werner Hilse is trying to puzzle out why.  If anyone else wants to
play with it and see if they can figure out why it is sometimes viral on
Linux and sometimes not, drop me a note offlist.

