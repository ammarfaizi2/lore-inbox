Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264083AbTFKETf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 00:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264097AbTFKETf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 00:19:35 -0400
Received: from air-2.osdl.org ([65.172.181.6]:42150 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264083AbTFKETe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 00:19:34 -0400
Message-ID: <33002.4.64.196.31.1055305996.squirrel@www.osdl.org>
Date: Tue, 10 Jun 2003 21:33:16 -0700 (PDT)
Subject: [announce] linux kernel-janitor (KJ) patchsets
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <linux-kernel@vger.kernel.org>
X-Priority: 3
Importance: Normal
X-Mailer: SquirrelMail (version 1.2.11)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Kernel-Janitor patchsets
2003-06-10
Draft version 1
========================================

1.  KJ patchsets

The Kernel Janitors (KJ) project reviews patches, comments on them, screens
and/or merges them, and creates patchsets that contain them. These patchsets
are available for anyone to download and use.

Patches should be sent to "kernel-janitor-discuss@lists.sf.net"
for review.  Randy Dunlap (rddunlap@osdl.org) will compile-test
them and merge them into the -kj patchset if they pass review.

2.  KJ patchset review and approvals

A patch must be approved by at least two (2) KJ project developers and
receive no vetoes (rejects) before it is added to the -kj patchset.

3.  KJ patch forwarding
After a patch has been in the -kj patchset for 1 week (without problems) or
on request from another Linux tree maintainer, it will be forwarded to the
current Linux tree maintainer (Linus, Andrew, Marcelo, etc.) for merging.

4.  Where hosted

KJ patchsets are hosted at OSDL.org.  They will begin at
http://www.osdl.org/archive/rddunlap/kj-patches/ ...
but this is only a temporary location until a more permanent
solution is available (soon).

5.  Patchset type

. merged and separated patches available as a diff (optionally bzip2-
  compressed)
. maybe a BK tree in the future, but that won't be the only format

. separated (split) patches are forwarded to tree maintainers
  so that credits for the patches are logged

###
~Randy



