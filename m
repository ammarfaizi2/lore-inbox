Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261258AbTHSTTk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 15:19:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTHSTSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 15:18:44 -0400
Received: from tmr-02.dsl.thebiz.net ([216.238.38.204]:56593 "EHLO
	gatekeeper.tmr.com") by vger.kernel.org with ESMTP id S261258AbTHSTQV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 15:16:21 -0400
To: linux-kernel@vger.kernel.org
Path: gatekeeper.tmr.com!davidsen
From: davidsen@tmr.com (bill davidsen)
Newsgroups: mail.linux-kernel
Subject: Multiple LATEST files?
Date: 19 Aug 2003 19:08:07 GMT
Organization: TMR Associates, Schenectady NY
Message-ID: <bhtsin$8fm$1@gatekeeper.tmr.com>
X-Trace: gatekeeper.tmr.com 1061320087 8694 192.168.12.62 (19 Aug 2003 19:08:07 GMT)
X-Complaints-To: abuse@tmr.com
Originator: davidsen@gatekeeper.tmr.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ftp> dir LAT*
200 PORT command successful.
150 Opening ASCII mode data connection for file list.
-rw-rw-r--   1 korg     korg            0 Jul 27 17:22 LATEST-IS-2.6.0-test2
-rw-rw-r--   1 korg     korg            0 Aug  9 04:56 LATEST-IS-2.6.0-test3
226 Transfer complete.

Something didn't work as expected other than my little check script.
-- 
bill davidsen <davidsen@tmr.com>
  CTO, TMR Associates, Inc
Doing interesting things with little computers since 1979.
