Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTJ0EzZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Oct 2003 23:55:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263406AbTJ0EzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Oct 2003 23:55:25 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:16258
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S263277AbTJ0EzY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Oct 2003 23:55:24 -0500
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: re: Linux 2.6 features list update
Message-Id: <E1ADzPx-0002Hl-00@penngrove.fdns.net>
Date: Sun, 26 Oct 2003 20:55:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think the section entitled "Laptops" is overly optimistic.  First,
as far as i know, suspend-to-disk has only this week been announced
(on this mailing list) for anything other than the i386 platform, and
even there, many laptops only marginally work with software suspend/
suspend-to-disk.  I really doubt that any file system utilizing USB or
ieee1394 is going to work reliably (if at all) with suspend for many
laptops in the near future.  I think the 2.6.0 shakedown and the amount
of attention (or lack thereof) given to suspend-related bugs makes it
clear that suspend-to-disk/software suspend is still experimental in
this release.

I sincerely hope that changes very soon and i will do what i can to 
help.  Meanwhile, please qualify that section to read:

   ... now supports full software-suspend-to-disk functionality on many
								-------
   laptops for the Linux user on the go.
   -------				  [emphasis to show added text]

It's definitely improved, but in many instances (especially where the 
laptop manufacturer has not provided full hardware/BIOS documentation),
it does not work well and may be difficult to make reliable in the near
future.

Respectfully submitted,
				-- JM
