Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284775AbRLMSxK>; Thu, 13 Dec 2001 13:53:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284813AbRLMSxA>; Thu, 13 Dec 2001 13:53:00 -0500
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:47460 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S284775AbRLMSwv>; Thu, 13 Dec 2001 13:52:51 -0500
Newsgroups: comp.lang.python.announce
Date: Thu, 13 Dec 2001 13:52:49 -0500 (EST)
From: Elliot Lee <sopwith@redhat.com>
X-X-Sender: <sopwith@devserv.devel.redhat.com>
Reply-To: Elliot Lee <sopwith@redhat.com>
To: <linux-kernel@vger.kernel.org>
Subject: ANN: pyven-1.0.2 - userland filesystems in python
Message-ID: <Pine.LNX.4.33.0112131342450.491-100000@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp://people.redhat.com/sopwith/pyven-1.0.2.tar.gz

This module makes it easier to write a filesystem in Python, using the
kernel<->venus interface of the coda filesystem module to handle VFS calls
in userland.

Currently only tested on Linux. Port to *BSD should be near trivial,
Solaris is doable, Windows is theoretically possible.

Flames, patches, comments to me. Flames about "writing a filesystem in 
python is stupid" to /dev/null, I'm not proposing writing ext4 in it... :)
-- Elliot

