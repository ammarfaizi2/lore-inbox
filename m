Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262116AbTIWWqV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 18:46:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262119AbTIWWqV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 18:46:21 -0400
Received: from smtp016.mail.yahoo.com ([216.136.174.113]:59142 "HELO
	smtp016.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262116AbTIWWqU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 18:46:20 -0400
Subject: Re: [BUG][v2.6.0-test5] __ext3_journal_get_write_access<2>EXT3-fs
	error
From: =?ISO-8859-1?Q?Ram=F3n?= Rey Vicente <retes_simbad@yahoo.es>
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
In-Reply-To: <1064189513.13147.23.camel@debian>
References: <1063058883.908.6.camel@debian>
	 <1064189513.13147.23.camel@debian>
Content-Type: text/plain; charset=iso-8859-15
Message-Id: <1064357165.998.16.camel@debian>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 24 Sep 2003 00:46:06 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El lun, 22-09-2003 a las 02:11, Ramón Rey Vicente escribió:
> El mar, 09-09-2003 a las 00:08, Ramón Rey Vicente escribió:
> > Hi
> > 
> > This happens deleting a big directory (~400 MiB) with many files and
> > subdirs
> 
> I just try to reproduce this problem, but now with the htree support
> disabled (without dir_index ext3 option) and the problem dissapears.

I forget this happened with latest linux-2.6-test-bk at  2003-09-23
12:58:42-07:00
-- 
Ramón Rey Vicente       <ramon dot rey at hispalinux dot es>
        jabber ID       <rreylinux at jabber dot org>
------------------------------------------------------------
gpg public key ID 0xBEBD71D5 # http://pgp.escomposlinux.org/

