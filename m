Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284639AbRLPOxy>; Sun, 16 Dec 2001 09:53:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284643AbRLPOxo>; Sun, 16 Dec 2001 09:53:44 -0500
Received: from mons.uio.no ([129.240.130.14]:63991 "EHLO mons.uio.no")
	by vger.kernel.org with ESMTP id <S284639AbRLPOxb>;
	Sun, 16 Dec 2001 09:53:31 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15388.46436.391494.196139@charged.uio.no>
Date: Sun, 16 Dec 2001 15:53:24 +0100
To: Dave Jones <davej@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: More fun with fsx.
In-Reply-To: <Pine.LNX.4.33.0112151745230.1425-100000@Appserv.suse.de>
In-Reply-To: <20011215154029.A3954@suse.de>
	<Pine.LNX.4.33.0112151745230.1425-100000@Appserv.suse.de>
X-Mailer: VM 6.92 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
Reply-To: trond.myklebust@fys.uio.no
From: Trond Myklebust <trond.myklebust@fys.uio.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> " " == Dave Jones <davej@suse.de> writes:

     > On Sat, 15 Dec 2001, Dave Jones wrote:
    >> The changes to make it work are trivial, and are at
    >> http://www.codemonkey.org.uk/cruft/fsx-linux.c (non-existant
    >> include & expected mmap() behaviour differences)

     > Whilst waiting for the local fs tests to finish/progress I did
     > a quick test with nfs. It dies after a while with an io error.

     > You can skip over the boring part and go straight to the
     > interesting failure case by using the options -c1234 -b 48870
     > Should happen quite quickly after that.

     > Full log of the failcase is at
     > http://www.codemonkey.org.uk/cruft/nfs-fsx.txt

Which kernel and mount options?

Cheers,
   Trond
