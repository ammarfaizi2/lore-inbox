Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283857AbRLEJGJ>; Wed, 5 Dec 2001 04:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283864AbRLEJGA>; Wed, 5 Dec 2001 04:06:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:53120 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S283857AbRLEJFv>;
	Wed, 5 Dec 2001 04:05:51 -0500
Date: Wed, 05 Dec 2001 01:05:48 -0800 (PST)
Message-Id: <20011205.010548.08321570.davem@redhat.com>
To: caulfield@sistina.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl32 patch for LVM
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20011205084407.C1040@tykepenguin.com>
In-Reply-To: <20011205084407.C1040@tykepenguin.com>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Patrick Caulfield <caulfield@sistina.com>
   Date: Wed, 5 Dec 2001 08:44:07 +0000

   Here is a patch for ioctl32.c that fixes problems compiling LVM in recent
   kernels - it seems a structure member name has been changed!
   
   I would guess that this (or a similar) fix will be needed for the other 32/64
   bit platforms.

This and much more correctness fixes are in Marcelo's queue
already.  It has been fixed in my tree for a long time, so
if you're impatiant go check it out:

   http://vger.kernel.org/

Franks a lot,
David S. Miller
davem@redhat.com
