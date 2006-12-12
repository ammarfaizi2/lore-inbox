Return-Path: <linux-kernel-owner+w=401wt.eu-S932247AbWLLRHK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932247AbWLLRHK (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 12:07:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbWLLRHK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 12:07:10 -0500
Received: from livid.absolutedigital.net ([66.92.46.173]:1249 "EHLO
	mx2.absolutedigital.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932247AbWLLRHI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 12:07:08 -0500
Date: Tue, 12 Dec 2006 12:06:33 -0500 (EST)
From: Cal Peake <cp@absolutedigital.net>
To: trivial@kernel.org
cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] Note subscribers only lists for input subsystem
Message-ID: <Pine.LNX.4.64.0612121157110.4219@lancer.cnet.absolutedigital.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

According to Dmitry in <http://lkml.org/lkml/2006/10/17/280>, the input 
list is subscribers only. I'm assuming here that both are but a 
confirmation would be nice... :)

From: Cal Peake <cp@absolutedigital.net>

Annotate the MAINTAINERS file to reflect the subscribers only nature of 
the input mailing lists.

Signed-off-by: Cal Peake <cp@absolutedigital.net>

--- ./MAINTAINERS~orig	2006-12-10 14:58:32.000000000 -0500
+++ ./MAINTAINERS	2006-12-12 11:56:01.000000000 -0500
@@ -1498,8 +1498,8 @@ INPUT (KEYBOARD, MOUSE, JOYSTICK) DRIVER
 P:	Dmitry Torokhov
 M:	dmitry.torokhov@gmail.com
 M:	dtor@mail.ru
-L:	linux-input@atrey.karlin.mff.cuni.cz
-L:	linux-joystick@atrey.karlin.mff.cuni.cz
+L:	linux-input@atrey.karlin.mff.cuni.cz (subscribers-only)
+L:	linux-joystick@atrey.karlin.mff.cuni.cz (subscribers-only)
 T:	git kernel.org:/pub/scm/linux/kernel/git/dtor/input.git
 S:	Maintained
 
