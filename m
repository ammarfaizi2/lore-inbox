Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271223AbTHCSVF (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 14:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271226AbTHCSVF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 14:21:05 -0400
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:1191 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S271223AbTHCSVD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 14:21:03 -0400
Date: Sun, 3 Aug 2003 14:20:44 -0400
From: Bastian <bbeutner@comcast.net>
To: linux-kernel@vger.kernel.org
Subject: issues with any ac sources, and 2.6
Message-Id: <20030803142044.41682583.bbeutner@comcast.net>
X-Mailer: Sylpheed version 0.9.3claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi, 
i run a tyan tiger s2462 board with dual athlons, with the gentoo flavor on it, 
recently i tried to run the ac sourcess kernel on this machine, however upon boot the machine would just freeze up in the middle of kernel boot, either dying while attaching ide's to devices or while detecting the ide chipset, the odd part to this is that using generic linux sources the machine boots just fine
the other issue seems to be that using the 2.6-beta versions it panic.
it does so by telling me that i have corrupt cpu context and then panics, there are no hints or warning as to what it could be 
any help would be greatly appreciated

