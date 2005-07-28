Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261493AbVG1WOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261493AbVG1WOO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Jul 2005 18:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261578AbVG1WOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Jul 2005 18:14:14 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:60056 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261493AbVG1WNC
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Jul 2005 18:13:02 -0400
Date: Fri, 29 Jul 2005 00:11:33 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: pascal.chapperon@wanadoo.fr, lars.vahlenberg@mandator.com,
       Alexey Dobriyan <adobriyan@gmail.com>, jgarzik@pobox.com
Subject: [patch 2.6.13-rc3] sis190 driver
Message-ID: <20050728221133.GA25857@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Single file patch:
http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3-sis190-test.patch

Patch-kit:
http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3/patches

Tarball:
http://www.zoreil.com/~romieu/sis190/20050728-2.6.13-rc3.tar.bz2

Changes from previous version (20050722)
o Add endian annotations (Alexey Dobriyan).

o Hopefully fixed the build of the patch.

o Minor round of mii/phy related changes. May crash.

Testing reports/review/patches are always appreciated.

Ok, now back to washing.

--
Ueimor
