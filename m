Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030196AbVINWQX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030196AbVINWQX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030199AbVINWQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:16:23 -0400
Received: from dsl-253-122.monet.no ([62.128.253.122]:13800 "EHLO
	postkontor.mopo.no") by vger.kernel.org with ESMTP id S1030196AbVINWQW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:16:22 -0400
Subject: Help porting wireless InProComm IPN 2220 driver to 2.6
From: Runar Ingebrigtsen <runar@mopo.no>
Reply-To: runar@mopo.no
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: mopo as
Date: Thu, 15 Sep 2005 00:15:59 +0200
Message-Id: <1126736159.19667.49.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

D-Link made a GPL driver for the InProComm IPN 2220 wireless chipset
found in Linksys cards.

Source: ftp://ftp.dlink.com/GPL/di624M/di624m_fw10_source.tar.gz

I really need this driver in the 2.6 kernel, as my current setup with
ndiswrapper and the neti2220.inf is unusable due to bad throughput.

If anyone would help me I'd be willing to pay an amount for a working
driver in the 2.6 tree. I would also need to get help using the driver
with Ubuntu.

The hardware is a Packard Bell EasyNote A5560 laptop:
https://wiki.ubuntu.com/HardwareSupportMachinesLaptopsPackardBell?highlight=%28packard%29%7C%28bell%29

-- 
Runar Ingebrigtsen <runar@mopo.no>
mopo as

