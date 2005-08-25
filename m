Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964898AbVHYWCH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964898AbVHYWCH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 Aug 2005 18:02:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964912AbVHYWCH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 Aug 2005 18:02:07 -0400
Received: from moutng.kundenserver.de ([212.227.126.186]:55752 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964898AbVHYWCG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 Aug 2005 18:02:06 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc64-dev@ozlabs.org
Subject: [PATCH 0/7] Cell SPU file system, snapshot 4
Date: Thu, 25 Aug 2005 23:53:10 +0200
User-Agent: KMail/1.7.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200508252353.10740.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thankfully, there is now documentation available to the world about
the Cell architecture (http://cell.scei.co.jp/e_download.html), so I
am now able to disclose more of our work on the SPU file system.

This is a rather big update compared to the previous version, as it
contains work from Mark Nutter and Ulrich Weigand to support context
save and restore of SPUs. This release should still be fully compatible
to the previous ones, but we intend to do incompatible changes for
in the future.

	Arnd <><

