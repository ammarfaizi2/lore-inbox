Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265744AbUAUQZ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 11:25:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265854AbUAUQZ1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 11:25:27 -0500
Received: from [65.248.109.87] ([65.248.109.87]:30605 "EHLO
	ns1.brianandsara.net") by vger.kernel.org with ESMTP
	id S265744AbUAUQZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 11:25:23 -0500
From: Brian Jackson <iggy@gentoo.org>
Organization: Gentoo Linux
To: linux-kernel@vger.kernel.org
Subject: possible memory leak in reiserfs
Date: Wed, 21 Jan 2004 10:26:03 -0600
User-Agent: KMail/1.6.50
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200401211026.04075.iggy@gentoo.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'd like some input on a bug that was recently reported to Gentoo's bugzilla.

http://bugs.gentoo.org/show_bug.cgi?id=38886

I personally don't know whether the behavior they are seeing is really a bug 
or not. All my systems show similar behavior, but the bug says that it is 
different than what happened prior to 2.4.22.

For some background gentoo-sources is based off of the -ck patchset, and aside 
from the stuff in the -ck patches, it doesn't touch anything in fs/reiser.

If anyone has any input I'd appreciate it. If you need more info, I can get it 
for you.

--Iggy
