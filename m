Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264972AbSKLA3A>; Mon, 11 Nov 2002 19:29:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265361AbSKLA3A>; Mon, 11 Nov 2002 19:29:00 -0500
Received: from ns.rf0.com ([198.78.66.18]:25871 "EHLO freebsd.rf0.com")
	by vger.kernel.org with ESMTP id <S264972AbSKLA3A>;
	Mon, 11 Nov 2002 19:29:00 -0500
Date: Tue, 12 Nov 2002 00:35:47 +0000 (GMT)
From: Rus Foster <rghf@fsck.me.uk>
X-X-Sender: rghf@freebsd.rf0.com
To: linux-kernel@vger.kernel.org
Subject: Filesystem corruption on 2.4.20-rc1?
Message-ID: <20021112003149.H90488-100000@freebsd.rf0.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
 has anyone seen filesystem (ext3) corruption on 2.4.20-rc1? I've just
upgraded and am now trying to get back as much as of data as possible but
its not looking pretty. fsck is saying no valid superblock (and I can't
find a backup super block :( ). I've got 3 disk on seperate controllers
and they have all got some form of corruption

If there is any more info please ask and I will see what I can dig out.
ATM I'm just trying to get the machine booting and recover some of my mp3
collection :)

Rus

--
http://www.fsck.me.uk - My blog
http://shells.fsck.me.uk - Hosting how you want it.

