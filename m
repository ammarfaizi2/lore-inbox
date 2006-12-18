Return-Path: <linux-kernel-owner+w=401wt.eu-S1753478AbWLRHwO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753478AbWLRHwO (ORCPT <rfc822;w@1wt.eu>);
	Mon, 18 Dec 2006 02:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753476AbWLRHwO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Dec 2006 02:52:14 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59293 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753475AbWLRHwN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Dec 2006 02:52:13 -0500
Date: Mon, 18 Dec 2006 08:52:10 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, util-linux-ng@vger.kernel.org
Subject: [ANNOUNCE] util-linux-ng
Message-ID: <20061218075210.GB5217@petra.dvoda.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



 I'm pleased to announce a new "util-linux-ng" project. This project
 is a fork of the original util-linux (2.13-pre7). 

 The goal of the project is to move util-linux code back to useful state, sync
 with actual distributions and kernel and make development more transparent end
 open.

 The short term goals (for 2.13 release):

	- remove all NFS code from util-linux-ng 
          (/sbin/mount.nfs from nfs-utils is replacement)
	- remove FS/device detection code
          (libblkid from e2fsprogs or libvolumeid is replacement)
	- move as much as possible patches from distributions to upstream

 Mailing list:
   http://vger.kernel.org/vger-lists.html#util-linux-ng

 FTP:
   ftp://ftp.kernel.org/pub/scm/utils/util-linux-ng/

 GIT:
   git clone git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git util-linux-ng

   [Note, GIT repo contains previous 47 versions of util-linux.]

        
 The mailing list or my private e-mail are open for your patches, ideas and
 suggestion. The mailing list is also place where you can help us review
 patches.

    Karel

-- 
 Karel Zak  <kzak@redhat.com>
