Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbVL3Dfl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbVL3Dfl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Dec 2005 22:35:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbVL3DfT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Dec 2005 22:35:19 -0500
Received: from smtp105.sbc.mail.re2.yahoo.com ([68.142.229.100]:58750 "HELO
	smtp105.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1750845AbVL3DfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Dec 2005 22:35:15 -0500
Message-Id: <20051230031906.503919000.dtor_core@ameritech.net>
Date: Thu, 29 Dec 2005 22:19:06 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Linus Torvalds <torvalds@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 0/3] Input patches for 2.6.15
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are 3 tiny input patches correcting typos introduced by conversion
to dynamic input_dev allocation.

 input/joystick/warrior.c |    2 +-
 usb/input/kbtab.c        |    2 +-
 usb/input/wacom.c        |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

--
Dmitry

