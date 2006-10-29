Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWJ2OWw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWJ2OWw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 29 Oct 2006 09:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWJ2OWw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 29 Oct 2006 09:22:52 -0500
Received: from [212.45.6.2] ([212.45.6.2]:10964 "EHLO televic-cs.ru")
	by vger.kernel.org with ESMTP id S932315AbWJ2OWv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 29 Oct 2006 09:22:51 -0500
From: <predator@mt9.ru>
Subject: -W -Wno-unused -Wno-sign-compare compile flags
To: linux-kernel@vger.kernel.org
X-Mailer: CommuniGate Pro WebUser Interface v.4.3.11
Date: Sun, 29 Oct 2006 17:22:48 +0300
Message-ID: <web-577743@televic-cs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello !linux-kernel

Does anybody try to compile latest linux-kernel with -W 
-Wno-unused -Wno-sign-compare CFLAGS? There is a tons of 
warnings :(
Recent versions of grsecurity patches adds this flags to 
default. When I asked to grsec developers, why did they do 
that, they answered: to show, how messy linux code is...
Is there any objections about it?
