Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264740AbTFVKk7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 06:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264854AbTFVKk7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 06:40:59 -0400
Received: from mailout.mbnet.fi ([194.100.161.24]:2322 "EHLO posti.mbnet.fi")
	by vger.kernel.org with ESMTP id S264740AbTFVKk6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 06:40:58 -0400
Message-ID: <1087.194.100.165.43.1056279285.squirrel@webmail.mbnet.fi>
Date: Sun, 22 Jun 2003 13:54:45 +0300 (EEST)
Subject: 2.5.72 ISDN: unknown symbol kstat__per_cpu
From: Kimmo Sundqvist <musher@mbnet.fi>
To: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.5)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-OriginalArrivalTime: 22 Jun 2003 10:54:41.0421 (UTC) FILETIME=[AEC56BD0:01C338AC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

I have 2.5.72, plus all files that have "isdn" in their name are patched
to -bk3
It compiles ok, but "modprobe hisax" results in Unknown symbol kstat__per_cpu

If there is a fix for this, will ISDN then work, or is there much to do
before I can use the Internet with itjust like in 2.4.20?

-Kimmo Sundqvist


