Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130678AbRCMLnu>; Tue, 13 Mar 2001 06:43:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130882AbRCMLnj>; Tue, 13 Mar 2001 06:43:39 -0500
Received: from rrzd1.rz.uni-regensburg.de ([132.199.1.6]:57106 "EHLO
	rrzd1.rz.uni-regensburg.de") by vger.kernel.org with ESMTP
	id <S130678AbRCMLn2>; Tue, 13 Mar 2001 06:43:28 -0500
To: linux-kernel@vger.kernel.org
Subject: FYI: [comp.protocols.time.ntp] announce: Linux PPS support for Kernel 2.4.2
From: Ulrich Windl <wiu09524@rrzc6.rz.uni-regensburg.de>
Date: 13 Mar 2001 12:42:10 +0100
Message-ID: <snf4rwxx5d9.fsf@rrzc6.rz.uni-regensburg.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

FYI, a copy...

------- Start of forwarded message -------
From: Ulrich Windl <wiu09524@rrzc6.rz.uni-regensburg.de>
Newsgroups: comp.protocols.time.ntp
Subject: announce: Linux PPS support for Kernel 2.4.2
Date: 13 Mar 2001 08:04:56 +0100
Organization: University of Regensburg, Germany
Message-ID: <snfg0giw3mv.fsf@rrzc6.rz.uni-regensburg.de>

I have uploaded the first working version of a patch for Linux-2.4.2 to
ftp://ftp.kernel.org:/pub/linux/daemons/ntp/PPS/PPS-2.4.2-pre5.diff.bz2

The patch is mostly equivalent to PPSkit-1.0.3, execpt lacking support
for CIOGETEV. Actually it seems that ATOM won't work without CIOGETEV,
but I'll have to re-investigate...

I would appreciate any feedback (see /usr/src/linux/CREDITS for EMail address)

Regards,
Ulrich
------- End of forwarded message -------
