Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946024AbWBOQ5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946024AbWBOQ5x (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 11:57:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946025AbWBOQ5x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 11:57:53 -0500
Received: from [213.91.10.50] ([213.91.10.50]:55765 "EHLO zone4.gcu-squad.org")
	by vger.kernel.org with ESMTP id S1946024AbWBOQ5w convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 11:57:52 -0500
Date: Wed, 15 Feb 2006 17:55:10 +0100 (CET)
To: linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] Quilt 0.44
X-IlohaMail-Blah: khali@localhost
X-IlohaMail-Method: mail() [mem]
X-IlohaMail-Dummy: moo
X-Mailer: IlohaMail/0.8.14 (On: webmail.gcu.info)
Message-ID: <lFUEkPbd.1140022510.6575600.khali@localhost>
From: "Jean Delvare" <khali@linux-fr.org>
Bounce-To: "Jean Delvare" <khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Greylist: Sender is SPF-compliant, not delayed by milter-greylist-2.1.2 (zone4.gcu-squad.org [127.0.0.1]); Wed, 15 Feb 2006 17:55:11 +0100 (CET)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all,

Quilt 0.44 has been released today. It fixes a serious bug in the push
command which could lead to data loss. Thanks to Peter Williams for
reporting. This bug was introduced in release 0.43, so I invite all
users of that release to upgrade to 0.44 quickly.

Quilt 0.44 can be downloaded from here:
  http://savannah.nongnu.org/download/quilt/quilt-0.44.tar.gz

Thanks,
--
Jean Delvare
