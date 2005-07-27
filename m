Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262025AbVG0Hxg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262025AbVG0Hxg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 03:53:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262039AbVG0Hxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 03:53:32 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:5869 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S262025AbVG0Hwr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 03:52:47 -0400
Date: Wed, 27 Jul 2005 09:52:29 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Andrew Morton <akpm@osdl.org>
cc: akihana@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: Reclaim space from unused ramdisk?
In-Reply-To: <20050726235624.4f3ca2a8.akpm@osdl.org>
Message-ID: <Pine.LNX.4.61.0507270951530.30941@yvahk01.tjqt.qr>
References: <4746469c05072615167ca234ce@mail.gmail.com>
 <Pine.LNX.4.61.0507270823490.10780@yvahk01.tjqt.qr> <20050726235624.4f3ca2a8.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> }
>> 
>
>hmm, yes.  That's a special-case in the ramdisk driver.
>
>The command `blockdev --flushbufs /dev/ram0' should have the same effect.

Interesting. Command not found, here. URL?



Jan Engelhardt
-- 
