Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422976AbWJRVUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422976AbWJRVUL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 17:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422964AbWJRVUK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 17:20:10 -0400
Received: from livid.absolutedigital.net ([66.92.46.173]:26117 "EHLO
	mx2.absolutedigital.net") by vger.kernel.org with ESMTP
	id S1422977AbWJRVUI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 17:20:08 -0400
Date: Wed, 18 Oct 2006 17:20:05 -0400 (EDT)
From: Cal Peake <cp@absolutedigital.net>
To: Dmitry Torokhov <dtor@insightbb.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Note subscriber only lists for input subsystem
Message-ID: <Pine.LNX.4.64.0610181715460.7303@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Cal Peake <cp@absolutedigital.net>

Annotate the MAINTAINERS file to reflect the subscribers only nature of 
the input mailing lists.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- ./MAINTAINERS~orig	2006-10-18 11:55:17.000000000 -0400
+++ ./MAINTAINERS	2006-10-18 17:12:11.000000000 -0400
@@ -1477,8 +1477,8 @@
 P:	Dmitry Torokhov
 M:	dmitry.torokhov@gmail.com
 M:	dtor@mail.ru
-L:	linux-input@atrey.karlin.mff.cuni.cz
-L:	linux-joystick@atrey.karlin.mff.cuni.cz
+L:	linux-input@atrey.karlin.mff.cuni.cz (subscribers-only)
+L:	linux-joystick@atrey.karlin.mff.cuni.cz (subscribers-only)
 T:	git kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
 S:	Maintained
 
