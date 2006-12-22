Return-Path: <linux-kernel-owner+w=401wt.eu-S1946030AbWLVKnZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946030AbWLVKnZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 22 Dec 2006 05:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946034AbWLVKnZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Dec 2006 05:43:25 -0500
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:41258 "EHLO
	hp3.statik.tu-cottbus.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1946030AbWLVKnX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Dec 2006 05:43:23 -0500
Message-ID: <458BB6CA.4080203@s5r6.in-berlin.de>
Date: Fri, 22 Dec 2006 11:43:22 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.8) Gecko/20061030 SeaMonkey/1.0.6
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: hot ejection of CardBus cards and ExpressCards
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Would-be driver programmer's question #217:
How has a driver's remove routine to account for hot ejection of a PCI
device? Does it merely boil down to that writing to device registers
doesn't have side effects anymore or is there more to it?
Thanks,
-- 
Stefan Richter
-=====-=-==- ==-- =-==-
http://arcgraph.de/sr/
