Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261628AbUEEFlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261628AbUEEFlq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 01:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262134AbUEEFlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 01:41:46 -0400
Received: from viefep20-int.chello.at ([213.46.255.26]:92 "EHLO
	viefep20-int.chello.at") by vger.kernel.org with ESMTP
	id S261628AbUEEFlp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 01:41:45 -0400
From: Anubis <kerub@gmx.net>
To: linux-kernel@vger.kernel.org, petri.koistinen@iki.fi, lathiat@sixlabs.org,
       janitor@sternwelten.at
Subject: Bug for making NETFILTER
Date: Wed, 5 May 2004 07:43:42 +0200
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200405050743.42833.kerub@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

make[3]: *** No rule to make target `net/ipv4/netfilter/ipt_mark.o', needed by 
`net/ipv4/netfilter/built-in.o'.  Stop.
for linux-2.6.5

Gnu C                  3.2.2
Gnu make               3.80
binutils               2.13.90.0.18
util-linux             2.11z
mount                  2.11z
module-init-tools      2.4.22
e2fsprogs              1.32
jfsutils               1.1.1
reiserfsprogs          3.6.4
xfsprogs               2.3.5
pcmcia-cs              3.2.4
quota-tools            3.08.
PPP                    2.4.1
nfs-utils              1.0.1
Linux C Library        2.3.1
Dynamic linker (ldd)   2.3.1
Linux C++ Library      5.0.2
Procps                 3.1.6
Net-tools              1.60
Kbd                    1.08
Sh-utils               2.0
Modules Loaded         i810_audio ac97_codec soundcore usb-ohci ehci-hcd 
usbcore sis900 pcmcia_core ide-scsi 3c59x
