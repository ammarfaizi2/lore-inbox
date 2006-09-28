Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030388AbWI1WSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030388AbWI1WSk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 18:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030387AbWI1WSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 18:18:40 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:36492 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932527AbWI1WSi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 18:18:38 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 0/3] swsusp: Add ioctl for swap files support and update documentation
Date: Fri, 29 Sep 2006 00:05:17 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609290005.17616.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The first two patches update the swsusp userland interface so that swap files
can be used as suspend storage by the userland tools and change the swsusp
documentation accordingly.

The last patch documents the recently merged swsusp testing code.

Please consider for applying.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

