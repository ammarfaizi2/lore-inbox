Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263315AbTDLP1T (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 11:27:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263316AbTDLP1T (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 11:27:19 -0400
Received: from ip-86-8.evc.net ([212.95.86.8]:60801 "EHLO hal9003.1g6.biz")
	by vger.kernel.org with ESMTP id S263315AbTDLP1R (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 11:27:17 -0400
From: Nicolas <linux@1g6.biz>
To: linux-kernel@vger.kernel.org
Subject: many oops 2.5.67
Date: Sat, 12 Apr 2003 17:38:57 +0200
User-Agent: KMail/1.5
Organization: 1G6
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304121738.57189.linux@1g6.biz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hi,

here are many oops seems related to :
mm, (and maybe reiserfs) on 2.5.67,
I can reproduce them,
at least at 4:00 hours (crontab checks makes me swap)
These are not under heavy loads...

Highmem is activated (1G Ram),
 on a SIS648 chipset, PIV2,6Ghz

http://1g6.biz/oops.txt  (65 Ko)
http://1g6.biz/System.map.bz2 (147 Ko)
http://1g6.biz/2.5.67  (my kernel 2.5.67, 1,2Mo)
http://1g6.biz/config   (28ko)

Hope this is useful,
Regards

Nicolas.
