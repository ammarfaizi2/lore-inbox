Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266043AbTLIS00 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 13:26:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266056AbTLIS00
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 13:26:26 -0500
Received: from imap.gmx.net ([213.165.64.20]:7062 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266043AbTLISYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 13:24:06 -0500
X-Authenticated: #377234
Date: 09 Dec 2003 00:00:00 +0000
From: koalasoft@gmx.de (Ulrich Mensfeld)
To: linux-kernel@vger.kernel.org
Message-ID: <8zZPc72uGbB@koalasoft>
Subject: Kernelpanic in 2.43
User-Agent: OpenXP/3.8.13-14 (Linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo,
don't know, whom to adress.

I've following problem: Every Linux-Kernel above 2.4.22 crashes with  
capslock and scrolllock blinking, nothing in the message-log, and all i  
can do is magic-sysreq and boot.

The problem seems to be reproducable: It seems to occur, when my son wants  
to use my pc as a router to the internet. So for detail:

My pc acts as a dsl-router  on "half"demand with packtfiltering and masq  
(ipchains) for 2 windows-pcs.
"Half"demand means, my son has to make a "ping 10.0.0.2" to open an  
outgoing connection, to prevent a bunch of windows tools opening unwanted  
connections using "DoD".

But this all works fine under 2.4.18 to 2.4.22. I haven't any idea, what  
that could be in 2.4.23.

If i should be more precise, please tell me what i should document.


Regards--
Ulrich
