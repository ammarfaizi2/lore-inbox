Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261786AbUDNVX0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Apr 2004 17:23:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261791AbUDNVX0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Apr 2004 17:23:26 -0400
Received: from adsl-207-214-87-84.dsl.snfc21.pacbell.net ([207.214.87.84]:58261
	"EHLO lade.trondhjem.org") by vger.kernel.org with ESMTP
	id S261786AbUDNVXY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Apr 2004 17:23:24 -0400
Subject: NFS_ALL patchsets updated for Linux-2.4.26...
From: Trond Myklebust <trond.myklebust@fys.uio.no>
To: nfs@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1081977800.2575.144.camel@lade.trondhjem.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Wed, 14 Apr 2004 14:23:20 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A number of people have written to ask for updates of the 2.4.x NFS_ALL
patchsets which were unchanged since 2.4.23 or so. I haven't done this
because the 2.4.23 patches should have applied fine to all kernels
between 2.4.23 and the 2.4.26-pre series.

Since we've now merged in several of the bugfixes that were already in
NFS_ALL into Marcelo's kernel, I have put out an updated NFS_ALL for
2.4.26. Please assume that it can be applied to any future 2.4.x kernels
until further notice.

Please also assume that, 2.4.x is feature-frozen. None of these patches
are therefore slated for inclusion into Marcelo's kernel. They are only
being provided in order to allow people who are currently relying on
these features in their private 2.4.x builds to continue to use them.

Please see

   http://www.fys.uio.no/~trondmy/src/Linux-2.4.x/2.4.26/

for further details.

Cheers,
  Trond
