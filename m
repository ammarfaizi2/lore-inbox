Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWJEHJc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWJEHJc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 03:09:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWJEHJc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 03:09:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:50083 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751178AbWJEHJb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 03:09:31 -0400
Subject: [ANNOUNCE] linux-kernel-headers-2.6.19-rc1.tar.gz
From: David Woodhouse <dwmw2@infradead.org>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Date: Thu, 05 Oct 2006 08:09:20 +0100
Message-Id: <1160032160.26064.17.camel@pmac.infradead.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.0 (2.8.0-7.fc6.dwmw2.2) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A full set of user-visible kernel headers for all supported
architectures, exported from the 2.6.19-rc1 kernel, has been uploaded
to
ftp://ftp.kernel.org/pub/linux/kernel/people/dwmw2/kernel-headers/snapshot/

I had planned to do this for 2.6.18 but it wasn't quite in good enough
shape by then. This one should be fine -- you can build your C library
against it and ship it in /usr/include. And tell me what breaks...

I probably won't do tarballs corresponding to -rc releases very often
but I'll do the proper releases.

-- 
dwmw2

