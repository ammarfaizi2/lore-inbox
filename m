Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262207AbTABPhv>; Thu, 2 Jan 2003 10:37:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262208AbTABPhv>; Thu, 2 Jan 2003 10:37:51 -0500
Received: from air-2.osdl.org ([65.172.181.6]:14788 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262207AbTABPht>;
	Thu, 2 Jan 2003 10:37:49 -0500
Date: Thu, 2 Jan 2003 07:43:31 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Robert P. J. Day" <rpjday@mindspring.com>
cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: kernel .config support?
In-Reply-To: <Pine.LNX.4.44.0301020930510.7804-100000@dell>
Message-ID: <Pine.LNX.4.33L2.0301020741110.22868-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Jan 2003, Robert P. J. Day wrote:

|   whatever happened to that funky option from 2.4 --
| for kernel .config support, which allegedly buried the
| config file inside the kernel itself.  (it never worked --
| the alleged extraction script scripts/extract-ikconfig
| depended on a program called "binoffset" that didn't
| exist in that distribution.)
|
|   any plans to resurrect this, or something like it?

Khalid Aziz et al (HP) have updated it to 2.5.
It's also part of the OSDL 2.5 DCL and CGL trees.
See http://developer.osdl.org/ for info on them.

I'll check to make sure there is a separate patch available for it
and repost it.

Thanks,
-- 
~Randy

