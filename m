Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267677AbSLFHXY>; Fri, 6 Dec 2002 02:23:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267678AbSLFHXY>; Fri, 6 Dec 2002 02:23:24 -0500
Received: from gbmail.cc.gettysburg.edu ([138.234.4.100]:22247 "EHLO
	gettysburg.edu") by vger.kernel.org with ESMTP id <S267677AbSLFHXY>;
	Fri, 6 Dec 2002 02:23:24 -0500
Date: Fri, 6 Dec 2002 02:10:00 -0500
To: linux-kernel@vger.kernel.org
Subject: IPSsec kernel panic
Message-ID: <20021206071000.GA7493@perseus.homeunix.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: Justin Pryzby <justinpryzby@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://lwn.net/Articles/16924/ reports that Debian's freeswan package
(http://packages.debian.org/testing/non-us/freeswan.html) causes a
kernel kernel panic due to improper handling of short packets.  A
userspace program shouldn't be able to cause a kernel panic (unless it
tries, and is priveliged), so I believe this indicates a kernel problem.

Justin

