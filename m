Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265579AbUATPhi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jan 2004 10:37:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265584AbUATPhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jan 2004 10:37:37 -0500
Received: from lnscu5.lns.cornell.edu ([128.84.44.111]:43281 "EHLO
	lnscu5.lns.cornell.edu") by vger.kernel.org with ESMTP
	id S265579AbUATPff (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jan 2004 10:35:35 -0500
From: Valentine Kouznetsov <vk@mail.lns.cornell.edu>
Organization: Cornell University
To: linux-kernel@vger.kernel.org
Subject: no mouse in 2.6.0 kernel
Date: Tue, 20 Jan 2004 10:34:50 -0500
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401201034.50583.vk@mail.lns.cornell.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the problem: no mouse in console and X modes on laptop with PS2 mouse.

Kernel generate message:
mice: PS/2 mouse device common for all mice
while loading mousedev, psmouse.
Module listing is indicating that mousedev is in use.
In console no mouse at all, in X it appears but don't move.
I have problems with Debian unstable (custom build kernel or
debian one) and RedHat.

The only discussion on the web can be found here:
http://www.linuxquestions.org/questions/history/131540

I just confirm it.

Could you please CC'd messages to me, I'm not on a list.
Thanks,
Valentine.
