Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317189AbSIEHNH>; Thu, 5 Sep 2002 03:13:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317194AbSIEHNH>; Thu, 5 Sep 2002 03:13:07 -0400
Received: from nixpbe.pdb.siemens.de ([192.109.2.33]:39112 "EHLO
	nixpbe.pdb.sbs.de") by vger.kernel.org with ESMTP
	id <S317189AbSIEHNG>; Thu, 5 Sep 2002 03:13:06 -0400
Subject: Re: ip_conntrack_hash() problem
From: Martin Wilck <Martin.Wilck@Fujitsu-Siemens.com>
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Andi Kleen <ak@suse.de>, Harald Welte <laforge@gnumonks.org>,
       Netfilter Mailing List <netfilter-devel@lists.netfilter.org>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       Patrick Schaaf <bof@bof.de>
In-Reply-To: <20020905044436.0772A2C0DF@lists.samba.org>
References: <20020905044436.0772A2C0DF@lists.samba.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 05 Sep 2002 09:19:01 +0200
Message-Id: <1031210342.9785.159.camel@biker.pdb.fsc.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Don, 2002-09-05 um 02.39 schrieb Rusty Russell:

> This work is already done:
> http://www.kernel.org/pub/linux/kernel/people/rusty/patches/Netfilter/conntrack_hashing.patch.gz

Well, beautiful.
Will this go into the main line kernel any time soon?
(I'd be for that).

If there's still need for discussion regarding this patch, as the thread
suggests, I'd propose to go for an intermediate, less intrusive fix like
mine first.

Martin

-- 
Martin Wilck                Phone: +49 5251 8 15113
Fujitsu Siemens Computers   Fax:   +49 5251 8 20409
Heinz-Nixdorf-Ring 1	    mailto:Martin.Wilck@Fujitsu-Siemens.com
D-33106 Paderborn           http://www.fujitsu-siemens.com/primergy





