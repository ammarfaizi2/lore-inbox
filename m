Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312886AbSCZAPS>; Mon, 25 Mar 2002 19:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312887AbSCZAPJ>; Mon, 25 Mar 2002 19:15:09 -0500
Received: from zeus.kernel.org ([204.152.189.113]:53734 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S312886AbSCZAO4>;
	Mon, 25 Mar 2002 19:14:56 -0500
Date: Mon, 25 Mar 2002 17:25:50 +0100 (CET)
From: Frank Cornelis <fcorneli@elis.rug.ac.be>
To: linux-kernel@vger.kernel.org
cc: Frank.Cornelis@elis.rug.ac.be
Subject: realtime processes and CD-ROM
Message-ID: <Pine.LNX.4.44.0203251716140.24395-100000@trappist.elis.rug.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

The MP3 player XMMS has the option of making it a realtime process.
But even after doing so, the music sometimes blocks. This is when my CDROM 
is being accessed when it is not spinning anymore (spin-up time).
Would it be very hard to reprogram the linux kernel in such a way that
certain devices can't be turned off when realtime processes access these
devices? These devices would include CDROM players, harddisks.
Please note that I'm not looking for a way to (globally) disable the 
spinning off of my CDROM player when it's in use. Only when realtime 
processes access these devices the spinning of should be disabled.
If anyone is programming on something like described above please let me 
know.

Frank.

PS: CC me, 'cause I'm not on the mailing list.

