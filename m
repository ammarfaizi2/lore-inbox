Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130514AbRBTUBm>; Tue, 20 Feb 2001 15:01:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130308AbRBTUBb>; Tue, 20 Feb 2001 15:01:31 -0500
Received: from burdell.cc.gatech.edu ([130.207.3.207]:32778 "EHLO
	burdell.cc.gatech.edu") by vger.kernel.org with ESMTP
	id <S130514AbRBTUBS>; Tue, 20 Feb 2001 15:01:18 -0500
Message-ID: <3A92CD06.F19F7C4B@cc.gatech.edu>
Date: Tue, 20 Feb 2001 15:01:10 -0500
From: Josh Fryman <fryman@cc.gatech.edu>
Organization: CoC, GaTech
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: query: IP over PCI?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

sorry if this is the wrong place... but:

there have been many references in the past (notably in the beowulf
community) about TCP/IP over PCI -- that was way back with kernel
2.2.9 and thereabouts (1999).  at that time, there were some patches
available to implement this...

i've done some recursive greps and what not through the 2.4.x trees, 
and searched all the various online sources of knowledge, but keep 
coming up blank today ...

can anyone inform me of the status for this?  we've got some
embedded PCI-card ARM boards that we'd like to run linux on, using
IP-over-PCI to tftp their kernel and NFS mount their filesystems...
as well as many other interesting things.  (these boards are in
regular x86 PC Linux hosts.  the actual boards are Intel IXP1200
units.)

any pointers, or FAQs, or <insert reference here> would be vastly
appreciated.

thanks,

josh fryman
