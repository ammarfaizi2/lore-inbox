Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262089AbUCVUvN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 15:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262665AbUCVUvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 15:51:13 -0500
Received: from isp17.tpi.pl ([193.110.121.246]:32733 "EHLO conecto.pl")
	by vger.kernel.org with ESMTP id S262089AbUCVUvM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 15:51:12 -0500
From: =?iso-8859-2?q?Micha=B3_Roszka?= <michal@roszka.pl>
Reply-To: michal@roszka.pl
To: linux-kernel@vger.kernel.org
Subject: 2.5.6-rc2, powerpc, ati radeon 9000 pro - blank screen
Date: Mon, 22 Mar 2004 21:51:03 +0100
User-Agent: KMail/1.6.1
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Message-Id: <200403222151.03751.michal@roszka.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I have 2.6.3 with fully working 2.6.3 kernel (framebuffer and XFree 8.6).
Today I compiled 2.6.5-rc2 with a .config generated with make oldconfig. The 
old config was taken from that working 2.6.3.

2.6.5-rc2 boots but when framebuffer activates, the monitor is blank (I hear 
only noise of HDD). I can log in with blind typing. The XFree also starts (I 
recognize it, because I can also log in with blind typing). But the monitor 
is blank.

What may be wrong?

My box is a Power Mac G4, 2x1.25GHz with ATI Radeon 9000 Pro.
-- 
Micha³ Roszka
michal@roszka.pl
