Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270382AbTGRUyY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 16:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270375AbTGRUyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 16:54:23 -0400
Received: from f08a-4-14.d1.club-internet.fr ([212.194.171.14]:2176 "EHLO
	universe") by vger.kernel.org with ESMTP id S271853AbTGRUxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 16:53:40 -0400
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16152.21463.599962.951884@silence.xenomai.org>
Date: Fri, 18 Jul 2003 22:08:55 +0200
To: linux-kernel@vger.kernel.org
Cc: karim@opersys.com
Subject: [ANNOUNCE] Adeos m3
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Adeos m3 for Linux is available at
http://savannah.nongnu.org/download/adeos/releases/adeos-m3.tar.gz.

This third milestone provides support for the following platforms:

o 2.4.{19,20,21} and 2.6.0-test1 on x86 hardware (UP and SMP).
o 2.4.20-uc0 on ARM-nommu.

Quite a lot of work has taken place since m2 was released a year ago,
mostly aimed at improving stability and determinism in demanding
real-time environments.

People seeking "real world" use of Adeos should have a look at the
RTAI project: http://www.aero.polimi.it/~rtai/.

Regards,

Philippe.
