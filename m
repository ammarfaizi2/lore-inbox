Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264908AbSKYPlJ>; Mon, 25 Nov 2002 10:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264936AbSKYPlJ>; Mon, 25 Nov 2002 10:41:09 -0500
Received: from thebsh.namesys.com ([212.16.7.65]:21773 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S264908AbSKYPlJ>; Mon, 25 Nov 2002 10:41:09 -0500
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15842.17986.416305.106123@laputa.namesys.com>
Date: Mon, 25 Nov 2002 18:48:18 +0300
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: Terje Malmedal <terje.malmedal@usit.uio.no>
Cc: linux-kernel@vger.kernel.org,
       Reiserfs mail-list <Reiserfs-List@Namesys.COM>
Subject: Re: reiserfs and nfs. 
In-Reply-To: <E18GKCG-0003cp-00@aqualene.uio.no>
References: <E18GKCG-0003cp-00@aqualene.uio.no>
X-Mailer: VM 7.07 under 21.5  (beta6) "bok choi" XEmacs Lucid
X-NSA-Fodder: Nazi NSA Vince Foster clones genetic colonel Project Monarch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Terje Malmedal writes:
 > 
 > Hi, 
 > 
 > I'm nfs-exporting a reiserfs filesystem, the problem is that the
 > inode-number as seen from the client seems to change from time to
 > time. This confuses a number of programs, for instance Emacs believes
 > that the file changed under it when this happens.

This problem is not known. What version of reiserfs (3.5 or 3.6) and
kernel are you using? Is there any way to reproduce this problem?

 > 
 > Is this a known problem? Any known fix? I found a number of old
 > messages about problems with reiser and nfs, but not this
 > specifically.
 > 
 > -- 
 >  - Terje
 > malmedal@usit.uio.no

Nikita.

