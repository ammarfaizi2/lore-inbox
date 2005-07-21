Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261951AbVGUXMk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261951AbVGUXMk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 19:12:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261929AbVGUXMk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 19:12:40 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:11244 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261951AbVGUXMj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 19:12:39 -0400
Date: Fri, 22 Jul 2005 01:09:50 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: linux-kernel@vger.kernel.org
Cc: pascal.chapperon@wanadoo.fr, lars.vahlenberg@mandator.com,
       jgarzik@pobox.com, changch@sis.com
Subject: sis190 driver
Message-ID: <20050721230950.GA419@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

No major change from previous version. I'm quietly merging bits from
the SiS driver that Lars kindly pointed out. The detection of the
mac address is done differently.

I'll welcome feedback related to regressions and/or netconsole testing.

Single file patch:
http://www.zoreil.com/~romieu/sis190/20050722-2.6.13-rc2-sis190-test.patch

Patch-kit:
http://www.zoreil.com/~romieu/sis190/20050722-2.6.13-rc2/patches

Tarball:
http://www.zoreil.com/~romieu/sis190/20050722-2.6.13-rc2.tar.bz2

--
Ueimor
