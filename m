Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263175AbTDGBLe (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 21:11:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263176AbTDGBLe (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 21:11:34 -0400
Received: from tomts10.bellnexxia.net ([209.226.175.54]:15554 "EHLO
	tomts10-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263175AbTDGBLd (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 21:11:33 -0400
Date: Sun, 6 Apr 2003 21:18:56 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.5.66-bk12 causes "rpm" errors
Message-ID: <Pine.LNX.4.44.0304062117150.1198-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  got 2.5.66-bk12 to boot on my inspiron 8100, and ran 
"rpm -q iptables", got the following:

rpmdb: write: 0xbfffc2d0, 8192: Invalid argument
error: db4 error(22) from dbenv->open: Invalid argument
error: cannot open Packages index using db3 - Invalid argument (22)
error: cannot open Packages database in /var/lib/rpm
package iptables is not installed


  rebooted under 2.4.20, that command worked fine.

rday

