Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261367AbTEKWjI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 18:39:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261374AbTEKWjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 18:39:08 -0400
Received: from pizda.ninka.net ([216.101.162.242]:39303 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S261367AbTEKWjH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 18:39:07 -0400
Date: Sun, 11 May 2003 14:46:21 -0700 (PDT)
Message-Id: <20030511.144621.35018826.davem@redhat.com>
To: linux-kernel@vger.kernel.org
CC: linux-net@vger.kernel.org, netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru,
       jmorris@intercode.com.au
Subject: 2.4.x IPSEC backport available
From: "David S. Miller" <davem@redhat.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is a 2.4.x backport of IPSEC available.  However there is a
STRONG caveat about using these changes in that we absolutely refuse
to take bug reports against this release, 2.5.x is where the active
development is taking place and thus where the testing is supposed to
take place.

This patch is a convenience for people, and nothing more.

Fetch it from:

	ftp://ftp.kernel.org/pub/linux/kernel/davem/IPSEC/linux-2.4.21-ipsec.patch
	bk://kernel.bkbits.net/davem/ipsec-2.4/

Enjoy.
