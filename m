Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbTHZFSO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 01:18:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262579AbTHZFSN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 01:18:13 -0400
Received: from 170.007.dsl.vic.iprimus.net.au ([211.26.209.170]:1488 "EHLO
	jchojsig1.jasco.net.au") by vger.kernel.org with ESMTP
	id S262618AbTHZFSM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 01:18:12 -0400
Message-Id: <sf4b7a30.018@jchofs1.jasco.net.au>
X-Mailer: Novell GroupWise Internet Agent 6.5.1 
Date: Tue, 26 Aug 2003 15:17:45 +1000
From: "Rod Bacon" <rodb@jasco.net.au>
To: <linux-kernel@vger.kernel.org>
Subject: ERROR: Broken Via-Rhine NIC In "Stable" 2.4.22
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just attempted upgrade from 2.4.21 on a Via M10000 Mini-ITX system that
was working perfectly. 2.4.22 results in eth0 not working, and constant
"NETDEV WATCHDOG: eth0: transmit timed out. Resetting".



___________________________________
 
Rod Bacon - Technical Manager
JASCO Consulting - http://www.jasco.net.au 
Email - rodb@jasco.net.au 
Phone : 03 9432 6376     Fax : 03 9432 6378
