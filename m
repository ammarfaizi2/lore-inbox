Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbVAKQWp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbVAKQWp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 11:22:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262818AbVAKQWp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 11:22:45 -0500
Received: from adsl-298.mirage.euroweb.hu ([193.226.239.42]:26496 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S262808AbVAKQWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 11:22:40 -0500
To: akpm@osdl.org, torvalds@osdl.org
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/11] FUSE - Filesystem in Userspace
Message-Id: <E1CoOmg-0003IS-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Tue, 11 Jan 2005 17:22:18 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew, Linus,

This is mostly a resend, modulo problems discovered by Mike Waychison
and Brice Goglin in the previous submission.  Thanks for the review!

Please apply!

If you still have any gripes about FUSE, I'd very much like to know
about it (it stinks of microkernels, it's too complex, etc.), so I can
try to address them.

Thanks,
Miklos
