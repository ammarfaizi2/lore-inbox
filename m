Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266599AbUGUTTt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUGUTTt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 15:19:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266603AbUGUTTt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 15:19:49 -0400
Received: from mail.xor.ch ([212.55.210.163]:26129 "HELO mail.xor.ch")
	by vger.kernel.org with SMTP id S266599AbUGUTTs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 15:19:48 -0400
Message-ID: <40FEC1CF.269886D1@orpatec.ch>
Date: Wed, 21 Jul 2004 21:19:42 +0200
From: Otto Wyss <otto.wyss@orpatec.ch>
Reply-To: otto.wyss@orpatec.ch
X-Mailer: Mozilla 4.78 (Macintosh; U; PPC)
X-Accept-Language: de,en
MIME-Version: 1.0
To: "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Framebuffer and DVI-cable
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I just installed a ATI Radeon 7500 into my system and since I couldn't
sync both console and X acceptable (there was always a 4mm horizontal
missmatch) regardless that I always use fbdev for X. I connected my
SyncMaster 171T with a DVI-cable, whow no missmatch at all!

Astonishing my framebuffer driver now switches to the correct resolution
during startup itself, phantastic! I now could remove "fbset -a
1280x1024-60' from my profile. I can only advice anyone to switch to DVI
if he has a chance.

O. Wyss

-- 
See a huge pile of work at "http://wyodesktop.sourceforge.net/"
