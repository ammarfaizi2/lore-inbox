Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263728AbTJOR1o (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 13:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263731AbTJOR1o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 13:27:44 -0400
Received: from the.earth.li ([193.201.200.66]:55687 "EHLO the.earth.li")
	by vger.kernel.org with ESMTP id S263728AbTJOR1n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 13:27:43 -0400
Date: Wed, 15 Oct 2003 18:27:42 +0100
From: Jonathan McDowell <noodles@earth.li>
To: linux-kernel@vger.kernel.org
Subject: Linux 2.6.0-test7 - Suspend to Disk success
Message-ID: <20031015172742.GZ30375@earth.li>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0310081235280.4017-100000@home.osdl.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just a quick note to say that 2.6.0-test7 is the first kernel I've been
able to successfully suspend to disk with and then resume. Using
"echo -n disk > /sys/power/state" now works just fine and I haven't
needed to reboot my laptop (a Compaq Evo N200) since I started running
the kernel last week. Thanks!

J.

-- 
/-\                             |     Love is an attraction to a
|@/  Debian GNU/Linux Developer |   perfectly normal person you've
\-                              |   temporarily mistaken for a god.
