Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264506AbUDTXL4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264506AbUDTXL4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 19:11:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264343AbUDTXLO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 19:11:14 -0400
Received: from tmailb1.svr.pol.co.uk ([195.92.168.141]:45327 "EHLO
	tmailb1.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id S264280AbUDTXJE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 19:09:04 -0400
Subject: Re: e100 NETDEV WATCHDOG transmit timeout since 2.6.4
From: Eamonn Hamilton <eamonn.hamilton@saic.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1082502503.12775.6.camel@snifter.freeserve.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 21 Apr 2004 00:08:23 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hmm, looks like we have an element of commonality - I also am on a 10
MBit half duplex network ( an old corporate switch thing with no
auto-sensing ).

Unfortunately the chance of persuading the powers that be to buy some
less prehistoric networking gear is ... slight :)

I've also tried the eepro100 driver and get the same symptoms, but I
notice that both drivers use the mii module, which appears to be main
element of commonality.


-- 
Eamonn Hamilton <eamonn.hamilton@saic.com>

