Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286521AbSAPBts>; Tue, 15 Jan 2002 20:49:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289309AbSAPBti>; Tue, 15 Jan 2002 20:49:38 -0500
Received: from x35.xmailserver.org ([208.129.208.51]:26382 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP
	id <S286521AbSAPBtc>; Tue, 15 Jan 2002 20:49:32 -0500
X-AuthUser: davidel@xmailserver.org
Date: Tue, 15 Jan 2002 17:55:34 -0800 (PST)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@blue1.dev.mcafeelabs.com
To: Linus Torvalds <torvalds@transmeta.com>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: this is more interesting ...
Message-ID: <Pine.LNX.4.40.0201151752190.940-100000@blue1.dev.mcafeelabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Booting my machine with vanilla 2.5.3-pre1 ( obsiously with corrected
headers inclusion fix ) i've got and error from UMSDOS layer reporting a
failing msdos_read_super() ( at boot ) and a panic about a failure to
mount root. The interesting thing is that i do not have any msdos mounts,
least of all root.



- Davide


