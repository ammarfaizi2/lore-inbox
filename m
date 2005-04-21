Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261406AbVDUWOK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261406AbVDUWOK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 18:14:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261437AbVDUWOK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 18:14:10 -0400
Received: from stat16.steeleye.com ([209.192.50.48]:51640 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S261406AbVDUWMo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 18:12:44 -0400
Subject: [ANNOUNCE] SCSI repository move from BK to git
From: James Bottomley <James.Bottomley@SteelEye.com>
To: SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Thu, 21 Apr 2005 18:12:43 -0400
Message-Id: <1114121563.5054.49.camel@mulgrave>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is more or less forced by the fact that the 2.6.12-rc3 is now git
based.  So as of now I won't be updating linux-scsi.bkbits.net

Hopefully I've set up broadly similar functionality on www.parisc-
linux.org (with thanks to Dann Frazier and Paul Bame, the parisc-linux
web admins).

To view the currently available SCSI trees, go to

http://www.parisc-linux.org/cgi-bin/gitweb.pl

This is using Kay Sievers' scripts and should give you broadly similar
browsing capabilities to bkbits.

I'm still pushing the diffs and the change logs for all the trees into

http://www.parisc-linux.org/~jejb/scsi_diffs

which has almost the exact same content as the old BK based ones used to
have.  Since git is a very mobile target at the moment, I suspect the
diffs and the changelogs will be of most use to people.


James

P.S. if you have any general git questions, please, I don't want to hear
them.  Ask on the git mailing list:  git@vger.kernel.org (preferably
after having searched the archives http://marc.theaimsgroup.com/?l=git
first).


