Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272975AbTHPOsI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:48:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272977AbTHPOsI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:48:08 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:14049 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S272975AbTHPOsH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:48:07 -0400
Message-ID: <3F3E288B.3010105@cornell.edu>
Date: Sat, 16 Aug 2003 08:50:19 -0400
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5b) Gecko/20030727 Thunderbird/0.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test3 current - firewire compile error
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hopefully, this is not a duplicate post:
===========================================

drivers/ieee1394/nodemgr.c: In function `nodemgr_update_ud_names':
drivers/ieee1394/nodemgr.c:471: error: structure has no member named `name'
drivers/ieee1394/nodemgr.c: In function `nodemgr_create_node':
drivers/ieee1394/nodemgr.c:723: error: structure has no member named `name'
drivers/ieee1394/nodemgr.c: In function `nodemgr_update_node':
drivers/ieee1394/nodemgr.c:1318: error: structure has no member named `name'
drivers/ieee1394/nodemgr.c: In function `nodemgr_add_host':
drivers/ieee1394/nodemgr.c:1775: error: structure has no member named `name'
make[2]: *** [drivers/ieee1394/nodemgr.o] Error 1
make[1]: *** [drivers/ieee1394] Error 2
make: *** [drivers] Error 2


