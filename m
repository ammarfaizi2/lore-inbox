Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261939AbTFZP05 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jun 2003 11:26:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261932AbTFZP05
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jun 2003 11:26:57 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:12191 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP id S261939AbTFZP04
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jun 2003 11:26:56 -0400
From: Nikita Danilov <Nikita@Namesys.COM>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16123.5139.767962.494409@laputa.namesys.com>
Date: Thu, 26 Jun 2003 19:41:07 +0400
X-PGP-Fingerprint: 43CE 9384 5A1D CD75 5087  A876 A1AA 84D0 CCAA AC92
X-PGP-Key-ID: CCAAAC92
X-PGP-Key-At: http://wwwkeys.pgp.net:11371/pks/lookup?op=get&search=0xCCAAAC92
To: "Robert L. Harris" <Robert.L.Harris@rdlg.net>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: inode problem?
In-Reply-To: <20030626152946.GN21580@rdlg.net>
References: <20030626152946.GN21580@rdlg.net>
X-Mailer: ed | telnet under Fuzzball OS, emulated on Emacs 21.5  (beta14) "cassava" XEmacs Lucid
X-Uboat-Death-Message: TORPEDOED BY CORVETTE. TORPEDOS. LEAVE BOAT. U-383.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert L. Harris writes:
 > 
 > 
 >   I have a system at work that seems to have an ext3 filesystem made 
 > with -T largefile when it really shouldn't have and is running low on 
 > inodes.  A co-worker has mentioned that reiserfs doesn't have inode 
 > problems.  I tried to look this up but am having problems 
 > verifying/denying this:
 > 
 > {0}:Documentation>host www.reiserfs.org
 > www.reiserfs.org does not exist, try again

$ host www.reiserfs.org
www.reiserfs.org has address 212.16.7.65

(you can also use namesys.com)

 > 
 > Whois also doesn't return anything.  Anyone have any proof either way
 > and news on the current stability of reiserfs in the 2.4.21 tree?

It exists and is stable.

 > 
 > Robert
 > 

Nikita.

 > 
