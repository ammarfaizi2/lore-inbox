Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265619AbUAZXiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jan 2004 18:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265620AbUAZXiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jan 2004 18:38:12 -0500
Received: from sandershosting.com ([69.26.136.138]:2721 "HELO
	sandershosting.com") by vger.kernel.org with SMTP id S265619AbUAZXiF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jan 2004 18:38:05 -0500
Content-Type: text/plain; charset=US-ASCII
From: David Sanders <linux@sandersweb.net>
Reply-To: David Sanders <linux@sandersweb.net>
Organization: SandersWeb.net
Message-Id: <200401261834.54450@sandersweb.net>
To: linux-kernel@vger.kernel.org
Subject: atkbd.c: Unknown key released
Date: Mon, 26 Jan 2004 18:37:37 -0500
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I keep getting the following in my syslog whenever I startx:

Jan 26 13:43:56 debian kernel: atkbd.c: Unknown key released 
(translated set 2, code 0x7a on isa0060/serio0).
Jan 26 13:43:56 debian kernel: atkbd.c: This is an XFree86 bug. It 
shouldn't access hardware directly.
Jan 26 13:43:57 debian kernel: atkbd.c: Unknown key released 
(translated set 2, code 0x7a on isa0060/serio0).
Jan 26 13:43:57 debian kernel: atkbd.c: This is an XFree86 bug. It 
shouldn't access hardware directly.

I don't get the error with the 2.4.24 kernel.
-- 
David Sanders
linux@sandersweb.net
