Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261334AbTIRNyY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 09:54:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbTIRNyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 09:54:24 -0400
Received: from pD9512F47.dip.t-dialin.net ([217.81.47.71]:26097 "EHLO
	snafu.domain.de") by vger.kernel.org with ESMTP id S261334AbTIRNyX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 09:54:23 -0400
Date: Thu, 18 Sep 2003 15:55:57 +0200
From: Michael Bode <debian_list@arcor.de>
To: linux-kernel@vger.kernel.org
Subject: bug-report
Message-ID: <20030918135557.GA678@snafu.domain.de>
Reply-To: debian_list@arcor.de
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi!

this is my first bug-report for a kernel, so i'm sorry when it is not
perfect.

i have compiled kernel 2.4.22 and the kernel runs very good. today i
want to make menuconfig a 2. time with the same target.

cd /usr/src/linux-2.4.22
su
make menuconfig

Menuconfig has encountered a possible error in one of the kernel's
configuration files and is unable to continue.  Here is the error
report:


Please report this to the maintainer <mec@shout.net>.  You may also
send a problem report to <linux-kernel@vger.kernel.org>.

Please indicate the kernel version you are trying to configure and
which menu you were trying to enter when this error occurred.

make: *** [menuconfig] Fehler 1

my system:
debian sid
gcc 3.3.2
athlon 2400+

best regards
michael
