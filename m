Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261518AbSL2T7S>; Sun, 29 Dec 2002 14:59:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261523AbSL2T7S>; Sun, 29 Dec 2002 14:59:18 -0500
Received: from dsl-67-48-44-237.telocity.com ([67.48.44.237]:5933 "EHLO
	lnuxlab.ath.cx") by vger.kernel.org with ESMTP id <S261518AbSL2T7R>;
	Sun, 29 Dec 2002 14:59:17 -0500
Date: Sun, 29 Dec 2002 15:26:10 -0500
To: linux-kernel@vger.kernel.org
Subject: 2.5.53-mm3: xmms: page allocation failure. order:5, mode:0x20
Message-ID: <20021229202610.GA24554@lnuxlab.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: khromy@lnuxlab.ath.cx (khromy)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Running 2.5.53-mm3, I found the following in dmesg.  I don't remember
getting anything like this with 2.5.53-mm3.

xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:3, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20
xmms: page allocation failure. order:5, mode:0x20
xmms: page allocation failure. order:4, mode:0x20

-- 
L1:	khromy		;khromy(at)lnuxlab.ath.cx
