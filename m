Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262561AbULDRkh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262561AbULDRkh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 12:40:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262562AbULDRkh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 12:40:37 -0500
Received: from kvaalen.no ([80.203.204.246]:33691 "EHLO athlon.kvaalen.no")
	by vger.kernel.org with ESMTP id S262561AbULDRkd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 12:40:33 -0500
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kernel CVS is malfunctioning
References: <20041204032723.GX32635@dualathlon.random>
From: =?iso-8859-1?q?H=E5vard_Kv=E5len?= <havardk@kvaalen.no>
Date: Sat, 04 Dec 2004 18:40:17 +0100
In-Reply-To: <fa.i7vl3ki.m0gsji@ifi.uio.no> (Andrea Arcangeli's message of
 "Sat, 4 Dec 2004 03:29:00 GMT")
Message-ID: <m3is7iezcu.fsf@athlon.kvaalen.no>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli <andrea@suse.de> writes:

> The kernel CVS seems screwed. cvsps -x --bkcvs tells there are 2
> checkins.

This has already been reported to linux-kernel:

| From: Larry McVoy <lm@bitmover.com>
| To: linux-kernel@vger.kernel.org
| Subject: [BK2CVS] locking problems on kernel.org
| Date:  Fri, 3 Dec 2004 06:53:07 -0800
| Message-Id: <200412031453.iB3Er70l003000@work.bitmover.com>
|
| The last few days the locking mechanism on kernel.org has been broken.
| The result is that the CVS export tree isn't getting updated.  I've mailed
| the admins and gotten no response, does anyone know who manages that
| machine?

 - Håvard
