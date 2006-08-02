Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWHBRAr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWHBRAr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 13:00:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWHBRAr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 13:00:47 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:64932 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751232AbWHBRAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 13:00:46 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 0/3] swsusp cleanups
Date: Wed, 2 Aug 2006 18:42:21 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608021842.21774.rjw@sisk.pl>
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches contain some small clean up some functions
in kernel/power/snapshot.c and mm/page_alloc.c.

Greetings,
Rafael

