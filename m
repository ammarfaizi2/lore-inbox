Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291059AbSAaNFR>; Thu, 31 Jan 2002 08:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291061AbSAaNFH>; Thu, 31 Jan 2002 08:05:07 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:27777 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S291059AbSAaNFE>; Thu, 31 Jan 2002 08:05:04 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Thu, 31 Jan 2002 05:04:44 -0800
Message-Id: <200201311304.FAA00344@adam.yggdrasil.com>
To: romieu@cogenit.fr, romieu@ensta.fr
Subject: linux-2.4.3/drivers/net/wan/dscc4.c does not compile
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	linux-2.4.3/drivers/net/wan/dscc4.c does not compile because
it referes to the undefined data structure "sync_serial_settings".
The changes that cause these problems were newly added in 2.4.3.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
