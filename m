Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262266AbSLZDpc>; Wed, 25 Dec 2002 22:45:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSLZDpc>; Wed, 25 Dec 2002 22:45:32 -0500
Received: from air-2.osdl.org ([65.172.181.6]:44974 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S262266AbSLZDpb>;
	Wed, 25 Dec 2002 22:45:31 -0500
Date: Wed, 25 Dec 2002 19:51:22 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: PATCH: put ext2 next to ext3 in config
In-Reply-To: <20021225150808.GB721@gallifrey>
Message-ID: <Pine.LNX.4.33L2.0212251945220.26694-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Good, thanks for doing this.  :)

I would prefer to see some of this help text in
Documentation/filesystems/ext*.txt, but this is still good.

--
~Randy

On Wed, 25 Dec 2002, Dr. David Alan Gilbert wrote:

| Minor little patch - this puts the Ext2 config switch next to the Ext3
| config switch in the config menus, and also calls it Ext2 rather than
| Second Extended.
|
| {<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}{<>}
| --- linux-2.5.53/fs/Kconfig.predag	2002-12-25 14:59:31.000000000 +0000
| +++ linux-2.5.53/fs/Kconfig	2002-12-25 15:00:43.000000000 +0000

