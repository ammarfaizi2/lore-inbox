Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262318AbSJEMw3>; Sat, 5 Oct 2002 08:52:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262321AbSJEMw3>; Sat, 5 Oct 2002 08:52:29 -0400
Received: from transport.cksoft.de ([62.111.66.27]:28170 "EHLO
	transport.cksoft.de") by vger.kernel.org with ESMTP
	id <S262318AbSJEMw2>; Sat, 5 Oct 2002 08:52:28 -0400
Date: Sat, 5 Oct 2002 12:57:48 +0000 (UTC)
From: "Bjoern A. Zeeb" <bzeeb-lists@lists.zabbadoz.net>
X-X-Sender: bz@e0-0.zab2.int.zabbadoz.net
To: Kai Makisara <Kai.Makisara@kolumbus.fi>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: SCSI st tape wrong minor in 2.5.40 with devfs
In-Reply-To: <Pine.LNX.4.44.0210051530430.5824-100000@kai.makisara.local>
Message-ID: <Pine.BSF.4.44.0210051255410.39858-100000@e0-0.zab2.int.zabbadoz.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 5 Oct 2002, Kai Makisara wrote:

> In the original location i did contain the device number but here it
> contains 4 (from the latest loop). The fix seems to be to replace i by
> dev_num but I have not yet tested it.

Thought of s.th. like this but had no old version a hand ..
I'll give it a look and if it seems ok, I'll give it a try and let you know ...

-- 
Bjoern A. Zeeb				bzeeb at Zabbadoz dot NeT
56 69 73 69 74				http://www.zabbadoz.net/

