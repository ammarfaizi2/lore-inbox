Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261915AbUDYHz6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261915AbUDYHz6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Apr 2004 03:55:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUDYHz6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Apr 2004 03:55:58 -0400
Received: from p50857D5C.dip.t-dialin.net ([80.133.125.92]:16004 "EHLO
	laura.nettrade.de") by vger.kernel.org with ESMTP id S261915AbUDYHz5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Apr 2004 03:55:57 -0400
Date: Sun, 25 Apr 2004 09:55:23 +0200 (MEST)
From: Matthias Jim Knopf <jim@users.de>
Reply-To: jim999@gmx.net
To: "Matthias \"Jim\" Knopf" <jim@users.de>
cc: linux-kernel@vger.kernel.org
Subject: "ls: .: Too many open files in system" with SMB-mounted directory
In-Reply-To: <32946.163.179.143.101.1082731449.squirrel@skarpsey.dyndns.org>
Message-ID: <Pine.LNX.4.21.0404250951010.3639-100000@laura.nettrade.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I keep on getting messages like this:

laura:/media/some_SMB_mounted_Directory # ls
ls: .: Too many open files in system

Haven't seen this before I upgraded to 2.4.25, and I do not have a public
server, lsof lists less than 3000 lines
The workarround is to press tab to make bash auto-complete, but I wonder
if there is a kernel-based configuration or some other info available?
Hope, somebody can help!

Greetings from germany, Jim
-- 
PGP encrypted mails welcome!
Slashdot in the year 2005: Free Win 1.0 released, M$ re-imports code

