Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270335AbUJUA5U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270335AbUJUA5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 20:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270532AbUJUA5L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 20:57:11 -0400
Received: from fw.osdl.org ([65.172.181.6]:31199 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270538AbUJTXyU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 19:54:20 -0400
Message-Id: <200410202354.i9KNsJ832322@mail.osdl.org>
To: linux-kernel@vger.kernel.org
Subject: [OSDL] osdl-aim-7 0.1.13
Date: Wed, 20 Oct 2004 16:54:19 -0700
From: Cliff White <cliffw@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Added some database scripts for results munging.

I took all the data from all the STP kernel runs
and made it into a MySQL database. 
Dump of same for number-crunching freex:
http://developer.osdl.org/cliffw/reaim/all_stp_reaim.dmp.bz2
( ~8MB compressed )

Scripts to create and query are in the test kit,
v 0.1.13, here:
bk://develper.osdl.org/reaim
and here:
http://sourceforge.net/projects/re-aim-7

Cute graphs showing linux-2.6.9 here:
http://developer.osdl.org/cliffw/reaim/compares/index.html
cliffw

