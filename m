Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130321AbQLEWBo>; Tue, 5 Dec 2000 17:01:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130480AbQLEWBf>; Tue, 5 Dec 2000 17:01:35 -0500
Received: from thalia.fm.intel.com ([132.233.247.11]:11533 "EHLO
	thalia.fm.intel.com") by vger.kernel.org with ESMTP
	id <S130321AbQLEWB1>; Tue, 5 Dec 2000 17:01:27 -0500
Message-ID: <D5E932F578EBD111AC3F00A0C96B1E6F07DBDDE6@orsmsx31.jf.intel.com>
From: "Dunlap, Randy" <randy.dunlap@intel.com>
To: "'Tigran Aivazian'" <tigran@veritas.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: [bug] vfsmount->count accounting broken again?
Date: Tue, 5 Dec 2000 13:30:53 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2650.21)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Andries wrote Monday 4-dec-2000 about a umount patch
> > for this:
> 
> Randy, presumably you mean the userspace side, yes? I.e. not 
> the kernel
> bug I reported. I should have put a subject [two bugs] 
> instead of [bug].

Right.  Sorry I wasn't more clear about that.

~Randy

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
