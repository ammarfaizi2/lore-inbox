Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129402AbRBXBiz>; Fri, 23 Feb 2001 20:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129525AbRBXBip>; Fri, 23 Feb 2001 20:38:45 -0500
Received: from web3506.mail.yahoo.com ([204.71.203.73]:7439 "HELO
	web3506.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S129402AbRBXBid>; Fri, 23 Feb 2001 20:38:33 -0500
Message-ID: <20010224013821.18282.qmail@web3506.mail.yahoo.com>
Date: Sat, 24 Feb 2001 01:38:21 +0000 (GMT)
From: Michèl Alexandre Salim 
	<salimma1@yahoo.co.uk>
Subject: 2.42 broke PCMCIA IDE
To: LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Just installed a custom Debian system using kernel
2.4.1 + ReiserFS (root running reiserfs) and it works
just fine. Since kernel 2.4.2 has been released, when
recompiling a new kernel (the 2.4.1 I used has been
trimmed to fit my modified boot disks) I used that
instead, after hearing about the multimode and
reiserfs bugs.

Kernel boots, and... pcmcia-cs starts with a high and
low beep. Card detected as a 5V using cardctl status,
but silly me, forgot to note the reading given by
cardctl ident.

Running Debian woody, 02/18 snapshot, using gcc
2.95.3. Hardware is the Sony Picturebook C1VE (Crusoe)

Any idea?

Cheers,

Michel

____________________________________________________________
Do You Yahoo!?
Get your free @yahoo.co.uk address at http://mail.yahoo.co.uk
or your free @yahoo.ie address at http://mail.yahoo.ie
