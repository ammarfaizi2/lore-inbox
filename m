Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315266AbSFJNv6>; Mon, 10 Jun 2002 09:51:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315335AbSFJNvY>; Mon, 10 Jun 2002 09:51:24 -0400
Received: from bitshadow.namesys.com ([212.16.7.71]:27520 "EHLO namesys.com")
	by vger.kernel.org with ESMTP id <S315300AbSFJNuV>;
	Mon, 10 Jun 2002 09:50:21 -0400
Date: Mon, 10 Jun 2002 17:42:56 +0400
From: Hans Reiser <reiser@bitshadow.namesys.com>
Message-Id: <200206101342.g5ADguY6003875@bitshadow.namesys.com>
To: torvalds@transmeta.com, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com
Subject: [BK] [2.5] reiserfs changeset 12 of 15 for 2.5.21
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a changeset 12 out of 15.

You can pull it from bk://namesys.com/bk/reiser3-linux-2.5
Or use plain text patch at the end of this message

   fix reiserfsprogs url. (First spotted by Alan Cox in 2.4)

Chris Mason spent a lot of efforts in helping to convert this changeset to
Linus-compatible form.

Diffstat:
 Changes |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

Plaintext patch:

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux kernel tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.605   -> 1.606  
#	Documentation/Changes	1.19    -> 1.20   
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/05/30	green@angband.namesys.com	1.606
# Changes:
#   fix reiserfsprogs url.
# --------------------------------------------
#
diff -Nru a/Documentation/Changes b/Documentation/Changes
--- a/Documentation/Changes	Thu May 30 18:42:27 2002
+++ b/Documentation/Changes	Thu May 30 18:42:27 2002
@@ -320,7 +320,7 @@
 
 Reiserfsprogs
 -------------
-o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.0b.tar.gz>
+o  <ftp://ftp.namesys.com/pub/reiserfsprogs/reiserfsprogs-3.x.1b.tar.gz>
 
 LVM toolset
 -----------
