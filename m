Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264665AbTAAU5K>; Wed, 1 Jan 2003 15:57:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264666AbTAAU5K>; Wed, 1 Jan 2003 15:57:10 -0500
Received: from mailout05.sul.t-online.com ([194.25.134.82]:42638 "EHLO
	mailout05.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S264665AbTAAU5J> convert rfc822-to-8bit; Wed, 1 Jan 2003 15:57:09 -0500
Content-Type: text/plain;
  charset="us-ascii"
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: WOLK - Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: set_current_state(); vs current->state = bla;
Date: Wed, 1 Jan 2003 22:05:13 +0100
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Message-Id: <200301012205.13131.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

$subject says it all. Is there _any_ reason why not to use set_current_state?

ciao, Marc
