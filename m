Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135691AbRD2IEZ>; Sun, 29 Apr 2001 04:04:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135692AbRD2IEQ>; Sun, 29 Apr 2001 04:04:16 -0400
Received: from freya.yggdrasil.com ([209.249.10.20]:58570 "EHLO
	ns1.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S135691AbRD2IEG>; Sun, 29 Apr 2001 04:04:06 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 29 Apr 2001 01:04:02 -0700
Message-Id: <200104290804.BAA11373@baldur.yggdrasil.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.4 sluggish under fork load
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	On rereading Linus's message, I see that he indicated that
"while true ; do /bin/true ; done" was known to be a bash bug, not
just a suggested possibility.  Sorry for acting as if this were
a new discovery.  Anyhow, I hope that at least the proposed bash
patch that I submitted may be of some use.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
