Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265424AbSKFBgb>; Tue, 5 Nov 2002 20:36:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265309AbSKFBgY>; Tue, 5 Nov 2002 20:36:24 -0500
Received: from air-2.osdl.org ([65.172.181.6]:40869 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S265424AbSKFBfk>;
	Tue, 5 Nov 2002 20:35:40 -0500
Date: Tue, 5 Nov 2002 17:37:37 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: <vojtech@suse.cz>
cc: <linux-kernel@vger.kernel.org>
Subject: busmouse support (2 of them?)
Message-ID: <Pine.LNX.4.33L2.0211051734410.21048-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

In (menu)config, there is
  Character Devices, Mice --->, Bus mouse support
and then there is
  Input drivers, Mice, Inport busmouse

Are both of these needed?  I.e., can the first one be removed?

-- 
~Randy
location: NPP-4E

