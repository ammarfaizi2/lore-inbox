Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262058AbUK3NB4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262058AbUK3NB4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Nov 2004 08:01:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbUK3NB4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Nov 2004 08:01:56 -0500
Received: from er-systems.de ([217.172.180.163]:4763 "EHLO er-systems.de")
	by vger.kernel.org with ESMTP id S262058AbUK3NBu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Nov 2004 08:01:50 -0500
Date: Tue, 30 Nov 2004 14:01:50 +0100 (CET)
From: Thomas Voegtle <tv@lio96.de>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.29-pre1 (resend)
In-Reply-To: <20041127144322.GA2564@dmt.cyclades>
Message-ID: <Pine.LNX.4.58.0411301353530.8333@er-systems.de>
References: <20041127144322.GA2564@dmt.cyclades>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>   o Marc-Christian Petersen: VM documentation update

Here is a typo.
/proc/sys/vm/vm_anon_lru is default 0


--- linux-2.4.29-pre1/Documentation/sysctl/vm.txt.old	2004-11-30 13:48:49.000000000 +0100
+++ linux-2.4.29-pre1/Documentation/sysctl/vm.txt	2004-11-30 13:49:13.000000000 +0100
@@ -307,7 +307,7 @@
 Low ram machines that swaps all the time want to turn
 this on (i.e. set to 1).
 
-The default value is 1.
+The default value is 0.
 =============================================================
 
 
 



-- 
 Thomas Vögtle    email: thomas@voegtle-clan.de
 ----- http://www.voegtle-clan.de/thomas ------
