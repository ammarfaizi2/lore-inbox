Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266884AbUHISyM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266884AbUHISyM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 14:54:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266853AbUHISvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 14:51:33 -0400
Received: from alpha.logic.tuwien.ac.at ([128.130.175.20]:15317 "EHLO
	alpha.logic.tuwien.ac.at") by vger.kernel.org with ESMTP
	id S266850AbUHISu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 14:50:29 -0400
Date: Mon, 9 Aug 2004 20:50:18 +0200
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       EdHamrick@aol.com
Subject: Consistent complete lock up with 2.6.8-rc2-mm1 and vuescan
Message-ID: <20040809185018.GA26084@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi Ed!

I have a bit of a problem here: I am scanning with vuescan (latest
version) on linux-2.6.8-rc3-mm1 a lot of images from raw files, i.e.
only data io from the hard disk, no usb etc interferes, and always after
20/30 something images the computer freezes completely. Not even Sysrq
works. Only reset button. Of course, the syslog shows up nothing.

Is there anything you two can think of what could be the reason?

(and no, I have no chance to use serial console, but I doubt it would be
useful)

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
BOTCHERBY
The principle by which British roads are signposted.
			--- Douglas Adams, The Meaning of Liff
