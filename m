Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284682AbRLEUk1>; Wed, 5 Dec 2001 15:40:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284676AbRLEUkQ>; Wed, 5 Dec 2001 15:40:16 -0500
Received: from air-1.osdl.org ([65.201.151.5]:23567 "EHLO osdlab.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S284682AbRLEUkD>;
	Wed, 5 Dec 2001 15:40:03 -0500
Date: Wed, 5 Dec 2001 12:36:09 -0800 (PST)
From: <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: "David S. Miller" <davem@redhat.com>
cc: <caulfield@sistina.com>, <linux-kernel@vger.kernel.org>
Subject: Re: ioctl32 patch for LVM
In-Reply-To: <20011205.010548.08321570.davem@redhat.com>
Message-ID: <Pine.LNX.4.33L2.0112051235250.22241-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Dec 2001, David S. Miller wrote:

|    From: Patrick Caulfield <caulfield@sistina.com>
|    Date: Wed, 5 Dec 2001 08:44:07 +0000
|
|    Here is a patch for ioctl32.c that fixes problems compiling LVM in recent
|    kernels - it seems a structure member name has been changed!
|
|    I would guess that this (or a similar) fix will be needed for the other 32/64
|    bit platforms.
|
| This and much more correctness fixes are in Marcelo's queue
| already.  It has been fixed in my tree for a long time, so
| if you're impatiant go check it out:
|
|    http://vger.kernel.org/

How does one do this, Dave?

That web page doesn't list anything about CVS...

Thanks,
-- 
~Randy

