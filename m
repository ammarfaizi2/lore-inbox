Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266304AbTGJIqL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jul 2003 04:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269086AbTGJIqL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jul 2003 04:46:11 -0400
Received: from flintstone.ichilton.net ([212.13.198.46]:42759 "EHLO
	flintstone.ichilton.net") by vger.kernel.org with ESMTP
	id S266304AbTGJIqJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jul 2003 04:46:09 -0400
Date: Thu, 10 Jul 2003 10:00:47 +0100
From: Ian Chilton <ian@ichilton.co.uk>
To: linux-kernel@vger.kernel.org
Subject: ACPI Battery Problem wth 2.4.22-pre4
Message-ID: <20030710090047.GC19385@roadrunner.ichilton.net>
Reply-To: Ian Chilton <ian@ichilton.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-PGP-Key: 6415CD8B
X-PGP-Key-FingerPrint: D0FF 2479 D63D 401E 6C7A  6363 A6FE 0B2D 6415 CD8B
X-GnuPG-Key-URL: http://ichilton.co.uk/pgp-public-key.txt
X-Operating-System: Linux 2.4.19-45um
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running 2.4.22-pre4 on a Dell Inspiron 5100 (with Debian/unstable).

It seem to work fine, except when I insert the battery, I get:

    ACPI-0352: *** Error: Looking up [Z000] in namespace, AE_NOT_FOUND
search_node c1594a80 start_node c1594a80 return_node 00000000
    ACPI-1121: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.BAT1._BIF] (Node c1594a80), AE_NOT_FOUND
    ACPI-0352: *** Error: Looking up [Z000] in namespace, AE_NOT_FOUND
search_node c1594a80 start_node c1594a80 return_node 00000000
    ACPI-1121: *** Error: Method execution failed
[\_SB_.PCI0.LPC0.BAT1._BIF] (Node c1594a80), AE_NOT_FOUND


Any ideas how to fix this?

[please cc me on replies!]


Thanks!


--ian
