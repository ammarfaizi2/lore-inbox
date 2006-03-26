Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932181AbWCZXMP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbWCZXMP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 18:12:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932185AbWCZXMP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 18:12:15 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:31151 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932181AbWCZXMO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 18:12:14 -0500
Date: Mon, 27 Mar 2006 01:12:08 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Edward Chernenko <edwardspec@yahoo.com>
cc: linux-kernel@vger.kernel.org, edwardspec@gmail.com
Subject: Re: [PATCH 2.6.15] Adding kernel-level identd dispatcher
In-Reply-To: <Pine.LNX.4.61.0603252016510.29793@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0603270110580.15593@yvahk01.tjqt.qr>
References: <20060324162107.50804.qmail@web37710.mail.mud.yahoo.com>
 <Pine.LNX.4.61.0603252016510.29793@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>This patch adds ident daemon to net/gnuidentd/
>>directory.
>>Apply to: 2.6.15.1.
>>Patch is here:
>>http://unwd.sourceforge.net/gnuidentd-2.6.15.patch
>>
>>I used two threads: one for connections handling and
>>another for tracking /etc/passwd changes through
>>inotify.
>>Additionally, root can set users hiding rules using
>>file in /proc. 
>>
>>I'm awaiting your notes/tips.

Are you even allowed to use the name "GNU identd"?
I'm not seeing your identd listed on GNU.org, that is, having
a page at http://www.gnu.org/software/identd/ like e.g. GRUB does.



Jan Engelhardt
-- 
