Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263564AbUBDTOr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 14:14:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264252AbUBDTOr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 14:14:47 -0500
Received: from mail4.l-3com.com ([166.20.84.205]:23499 "EHLO mail4.L-3com.com")
	by vger.kernel.org with ESMTP id S263564AbUBDTOq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 14:14:46 -0500
Message-ID: <3194.130.210.245.112.1075922081.squirrel@portunus.bgm.link.com>
Date: Wed, 4 Feb 2004 13:14:41 -0600 (CST)
Subject: acpi interrupts going haywire
From: "Casey Lancour" <cjlancour@link.com>
To: linux-kernel@vger.kernel.org
User-Agent: SquirrelMail/1.4.0
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
X-Priority: 3
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Problem:
im running the 2.4.20 kernel and my /proc/interrupts reports that my acpi
has like 4billion inturrupts going off and my system is sluggish
(rebooting fixes it).  It isnt intermitant! Yet i have about 100 of these
computers and not all of them do it, the bois settings and versions are
all the same as well as the harddisks and hardware. (the ones that have
the problem always have it and the ones that dont always dont)

Question:
I wanna log and trace what my kernel is doing at boot see if i can see if
there is a before and after for when the interrupts go nuts. how is this
done?

Could getting the latest Intel IA32 CPU microcode help? and adding
/dev/cpu support to kernel make any difference. as
http://urbanmyth.org/microcode/ isnt specific as to what the microcode
does.

thanks in advance,

     -=Casey
