Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161082AbVIBWCc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161082AbVIBWCc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 18:02:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161083AbVIBWCc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 18:02:32 -0400
Received: from rev.193.226.233.176.euroweb.hu ([193.226.233.176]:5382 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1161082AbVIBWCb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 18:02:31 -0400
To: akpm@osdl.org
CC: linux-kernel@vger.kernel.org, fuse-devel@lists.sourceforge.net,
       torvalds@osdl.org
Subject: FUSE merging?
Message-Id: <E1EBJc2-0006J0-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sat, 03 Sep 2005 00:02:18 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew!

Do you plan to send FUSE to Linus for 2.6.14?

I know you have some doubts about usefulness, etc.  Here are a couple
of facts, that I hope show that Linux should benefit from having FUSE:

 - total number of downloads from SF: ~25000

 - number of downloads of last release (during 3 months): ~7000

 - number of distros carrying official packages: 2 (debian, gentoo)

 - number of publicly available filesystems known: 27

 - of which at least 2 are carried by debian (and maybe others)

 - number of language bindings: 7 (native: C, java, python, perl, C#, sh, TCL)

 - biggest known commercial user: ~110TB exported, total bandwidth: 1.5TB/s

 - mailing list traffic 100-200 messages/month

 - have been in -mm since 2005 january

Miklos
