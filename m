Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261439AbVCRFjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261439AbVCRFjT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 00:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVCRFjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 00:39:19 -0500
Received: from mail2.sasken.com ([203.200.200.72]:64897 "EHLO mail2.sasken.com")
	by vger.kernel.org with ESMTP id S261437AbVCRFjM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 00:39:12 -0500
Date: Fri, 18 Mar 2005 11:08:57 +0530 (IST)
From: Subbu <subbu@sasken.com>
To: <linux-kernel@vger.kernel.org>, <linux-net@vger.kernel.org>
cc: <subbu2k_av@yahoo.com>
Subject: Network Driver Name (ATM Driver)
In-Reply-To: <Pine.GSO.4.30.0502221555380.17229-100000@sunrnd2.sasken.com>
Message-ID: <Pine.GSO.4.30.0503181100040.11189-100000@sunrnd2.sasken.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN;
	charset=US-ASCII
X-imss-version: 2.023
X-imss-result: Passed
X-imss-scores: Clean:99.90000 C:2 M:3 S:5 R:5
X-imss-settings: Baseline:1 C:1 M:1 S:1 R:1 (0.0000 0.0000)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi

I have a network driver (Ethernet), When i install the driver with insmod
the driver installs successfully
and with ifconfig -a i could see the ethernet driver name as eth0 or eth1
etc.
(net_device structure having variable name from where we will have
the name of the driver)


For ATM driver , it installs the driver without any problem.
but with ifconfig -a it doesn't show anything like the case in ethernet
driver.(i suppose it shows like atm0, atm1 or .. am i correct.??)B

How i can i get the driver name with "ifconfig -a" for PPPoATM driver.

Whats the function need to be included in the code to get the same..??
Kindly reply back to this mail ID and subbu2k_av@yahoo.com



Thanks in Advance
Subbu


"SASKEN RATED THE BEST EMPLOYER IN THE COUNTRY by the BUSINESS TODAY Mercer Survey 2004"


                           SASKEN BUSINESS DISCLAIMER
This message may contain confidential, proprietary or legally Privileged information. In case you are not the original intended Recipient of the message, you must not, directly or indirectly, use, Disclose, distribute, print, or copy any part of this message and you are requested to delete it and inform the sender. Any views expressed in this message are those of the individual sender unless otherwise stated. Nothing contained in this message shall be construed as an offer or acceptance of any offer by Sasken Communication Technologies Limited ("Sasken") unless sent with that express intent and with due authority of Sasken. Sasken has taken enough precautions to prevent the spread of viruses. However the company accepts no liability for any damage caused by any virus transmitted by this email
