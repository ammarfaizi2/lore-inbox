Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932455AbWBOOlp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932455AbWBOOlp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 09:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932456AbWBOOlp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 09:41:45 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:32896 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932455AbWBOOlo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 09:41:44 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 0/2] swsusp fixes
Date: Wed, 15 Feb 2006 14:34:03 +0100
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602151434.03575.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patches fix some bugs I've found recently in swsusp.  They don't
affect the mainline code.

Please apply.

Greetings,
Rafael

