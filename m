Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268706AbTCCSmx>; Mon, 3 Mar 2003 13:42:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268708AbTCCSmx>; Mon, 3 Mar 2003 13:42:53 -0500
Received: from pD9E5CB32.dip.t-dialin.net ([217.229.203.50]:50705 "EHLO
	consystor2.razik.de") by vger.kernel.org with ESMTP
	id <S268706AbTCCSmv>; Mon, 3 Mar 2003 13:42:51 -0500
From: Lukas@razik.de
To: linux-kernel@vger.kernel.org
Date: Mon, 03 Mar 2003 19:51:37 +0100
MIME-Version: 1.0
Subject: syslogd: WARNING error on linux input module
Message-ID: <3E63B249.25688.28FE4D0@localhost>
X-mailer: Pegasus Mail for Windows (v4.02, DE v4.02 R1a)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

After I've compiled the linux kernel 2.4.20 (without modules) I got this error message 
while starting the syslog daemon (msyslog-v1.08f):

--- ERRMESSAGE BEGIN ---
syslogd: linux input module: ksym_init: /proc/ksyms: No such file or directory
syslogd: WARNING error on linux input module
---  ERRMESSAGE END  ---

With my last kernel I had no troubles.
Could anybody tell me please, what I've done wrong?

thnx for your time!

