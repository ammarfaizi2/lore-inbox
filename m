Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261643AbSKCFTR>; Sun, 3 Nov 2002 00:19:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261645AbSKCFTQ>; Sun, 3 Nov 2002 00:19:16 -0500
Received: from [207.88.206.43] ([207.88.206.43]:35459 "EHLO
	intruder-luxul.gurulabs.com") by vger.kernel.org with ESMTP
	id <S261643AbSKCFTQ>; Sun, 3 Nov 2002 00:19:16 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Dax Kelson <dax@gurulabs.com>
To: Oliver Xymoron <oxymoron@waste.org>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, davej@suse.de
In-Reply-To: <20021103050344.GF18884@waste.org>
References: <20021103035017.GD18884@waste.org>
	<Pine.LNX.4.44.0211022004510.2503-100000@home.transmeta.com> 
	<20021103050344.GF18884@waste.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 02 Nov 2002 22:25:47 -0700
Message-Id: <1036301147.31698.153.camel@thud>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2002-11-02 at 22:03, Oliver Xymoron wrote:
> 
> Yes, but this has annoying side effects like booting single-user and
> discovering things like /sbin/ping doesn't exist because mount -a
> didn't run yet. Stuff like that sucks.
  
No. Because in single user mode, you are root.


Dax

