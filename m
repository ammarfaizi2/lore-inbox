Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270142AbTGMHSn (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jul 2003 03:18:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270144AbTGMHSn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jul 2003 03:18:43 -0400
Received: from hueytecuilhuitl.mtu.ru ([195.34.32.123]:36620 "EHLO
	hueymiccailhuitl.mtu.ru") by vger.kernel.org with ESMTP
	id S270142AbTGMHSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jul 2003 03:18:41 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
To: linux-kernel@vger.kernel.org
Subject: 2.5.75 - very poor GUI (KDE Kicker) feedback time
Date: Sun, 13 Jul 2003 11:30:21 +0400
User-Agent: KMail/1.5
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307131130.21980.arvidjaar@mail.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mandrake 9.1 (KDE 3.1.0) mostly unchanged, 2.5.75. Kicker is configured to 
enlarge icons on mouse over - now it takes several seconds to do it. Clicking 
on an icon in Kicker again takes several seconds before I get visual feedback 
and application starts to load.

It needs several seconds before tooltip appears after passing mouse over an 
icon in Kicker - and often it stays there as if mouse leave event has been 
lost.

Not sure how to even start debugging this, any pointers appreciated.

TIA

-andrey
