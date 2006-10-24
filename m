Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964902AbWJXO5p@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964902AbWJXO5p (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 10:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWJXO5p
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 10:57:45 -0400
Received: from hp3.statik.TU-Cottbus.De ([141.43.120.68]:60125 "EHLO
	hp3.statik.tu-cottbus.de") by vger.kernel.org with ESMTP
	id S964902AbWJXO5o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 10:57:44 -0400
Message-ID: <453E29E7.6090405@s5r6.in-berlin.de>
Date: Tue, 24 Oct 2006 16:57:43 +0200
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.8.0.5) Gecko/20060721 SeaMonkey/1.0.3
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: 2.6.19-rc2: known unfixed regressions (v3)
References: <Pine.LNX.4.64.0610130941550.3952@g5.osdl.org> <20061022122355.GC3502@stusta.de> <Pine.SOC.4.61.0610231757590.27929@math.ut.ee> <20061023205902.GK3502@stusta.de>
In-Reply-To: <20061023205902.GK3502@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

here is another one:

Subject    : [ohci1394 on PPC_PMAC] pci_set_power_state() failure and breaking suspend
References : http://lkml.org/lkml/2006/10/24/13
Submitter  : Benjamin Herrenschmidt <benh@kernel.crashing.org>
Caused-By  : Stefan Richter <stefanr@s5r6.in-berlin.de>
             commit ea6104c22468239083857fa07425c312b1ecb424
Status     : looking for answer when to ignore return code of pci_set_power_state

-- 
Stefan Richter
-=====-=-==- =-=- ==---
http://arcgraph.de/sr/
