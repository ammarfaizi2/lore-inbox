Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310850AbSCRNxI>; Mon, 18 Mar 2002 08:53:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310858AbSCRNw7>; Mon, 18 Mar 2002 08:52:59 -0500
Received: from boa.mtg-marinetechnik.de ([62.153.155.10]:16377 "EHLO
	anaconda.mtg-marinetechnik.de") by vger.kernel.org with ESMTP
	id <S310850AbSCRNwo>; Mon, 18 Mar 2002 08:52:44 -0500
Message-ID: <3C95F129.7D9744B5@gmx.net>
Date: Mon, 18 Mar 2002 14:52:41 +0100
From: Richard Ems <r.ems.mtg@gmx.net>
Reply-To: r.ems@gmx.net
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-4GB i686)
X-Accept-Language: en, de, es
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.18 freezes on heavy IO
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I'm seeing my system freeze on heavy IO. Only the reset button brings it
back to life again (ALT-SysRq-b also worked once). I'm running SuSE's
2.4.18-30 on a Pentium III (Coppermine) with 256 MB RAM (yes, I should
try vanilla 2.4.18, I will ...)
No SCSI, all IDE. LVM and ext3.
I don't get any oopses, no entries in /var/log/messages, nothing. I
mounted the ext3 partitions with the debug option but still no messages.
What options can I turn on to search for the problem? Any kernel boot
options? LVM/ext3 options?

Many thanks, Richard


-- 
   Richard Ems
   ... e-mail: r.ems@gmx.net
   ... Computer Science, University of Hamburg

   Unix IS user friendly. It's just selective about who its friends are.
