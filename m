Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261196AbVAWDYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261196AbVAWDYc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 22:24:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261198AbVAWDYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 22:24:31 -0500
Received: from compunauta.com ([69.36.170.169]:55788 "EHLO compunauta.com")
	by vger.kernel.org with ESMTP id S261196AbVAWDY1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 22:24:27 -0500
From: Gustavo Guillermo Perez <gustavo@compunauta.com>
Organization: compunauta
To: linux-kernel@vger.kernel.org
Subject: Supermount / ivman
Date: Sun, 23 Jan 2005 21:26:08 +0000
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200501232126.08575.gustavo@compunauta.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cause I play with old toys, (floppys) and ivman doesn't work properly on the 
lastest gentoo with floppys, I retouch for a while the supermount patch from 
sourceforge for kernel 2.6.11-rc1.

I'm a n00b on kernel, I do this only for general purposes helping some 
friends, I know supermount should not be used, and is not mantained, I've 
tested it just only for IDE/ATAPI CD/DVD and floppys.

Cause Supermount seems to be a filesystem I replace vfs_permission by 
generic_permission instead of permission as I read on the lkml. Other stuffs 
too in scsi section (I don't have scsi hardware).

If Help someone else:

http://www.compunauta.com/forums/linux/instalarlinux/supermount_en.html

-- 
Gustavo Guillermo Pérez
Compunauta uLinux
www.userver.tk
