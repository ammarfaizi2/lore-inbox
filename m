Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932168AbWAUM0L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbWAUM0L (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Jan 2006 07:26:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932169AbWAUM0L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Jan 2006 07:26:11 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:24000 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id S932168AbWAUM0K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Jan 2006 07:26:10 -0500
Message-ID: <43D2285A.8090806@t-online.de>
Date: Sat, 21 Jan 2006 13:26:02 +0100
From: Knut Petersen <Knut_Petersen@t-online.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.10) Gecko/20050726
X-Accept-Language: de, en
MIME-Version: 1.0
To: linux-fbdev-devel@lists.sourceforge.net
CC: linux-kernel@vger.kernel.org
Subject: [BUG] X and/or intelfb and/or input: lockup
X-Enigmail-Version: 0.86.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ID: bjGZ6kZHgeTBqdScoQPV7610aogoF928fxvgAzy4tqoiGJZTJhPW0j@t-dialin.net
X-TOI-MSGID: 97dde733-2ddf-441e-a85c-e88f341c640c
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

System description:
   - AOpen i915GMm-HFS, Pentium M 750
   - The software once was a SuSE 9.2, Xorg is updated to 6.9
   - intelfb

Occasionally the system locks up while switching from X
to the framebuffer console. The keyboard is completely
dead, monitor turns black. Shutdown by pressing the
power button works, but the logs contain no indication
of a problem.

Any ideas?

cu,
 Knut
