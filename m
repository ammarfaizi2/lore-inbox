Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932113AbWITVV7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932113AbWITVV7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 17:21:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932122AbWITVUz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 17:20:55 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:19365 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932115AbWITVUg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 17:20:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: [PATCH -mm 0/6] swsusp: Add support for swap files
Date: Wed, 20 Sep 2006 21:20:57 +0200
User-Agent: KMail/1.9.1
Cc: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609202120.58082.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following series of patches makes swsusp support swap files.

For now, it is only possible to suspend to a swap file using the in-kernel
swsusp and the resume cannot be initiated from an initrd.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

