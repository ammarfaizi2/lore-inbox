Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261837AbULJWFR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261837AbULJWFR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Dec 2004 17:05:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbULJWFR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Dec 2004 17:05:17 -0500
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:7691 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S261832AbULJWFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Dec 2004 17:05:12 -0500
Message-ID: <41BA0245.4050502@lougher.demon.co.uk>
Date: Fri, 10 Dec 2004 20:08:37 +0000
From: Phillip Lougher <phillip@lougher.demon.co.uk>
User-Agent: Mozilla Thunderbird 0.8 (X11/20041012)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
       "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: [Announce] Squashfs 2.1 released (compressed filesystem)
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

I'm pleased to announce the release of Squashfs 2.1.  This release 
introduces indexed directories which considerably speed up directory 
lookup (ls, find, etc.) for directories which are greater than 8K in 
size.  All directories are now also sorted alphabetically which further 
speeds up directory lookup.

Many smaller improvements have also been made in this release, and there 
are, for the first time, the results of some tests of Squashfs lookup 
and I/O performance against Zisofs, Cloop, and CRAMFS.

For further details please go to the project page 
http://squashfs.sourceforge.net.

Regards

Phillip Lougher
