Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261186AbUCPSba (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 13:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbUCPSba
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 13:31:30 -0500
Received: from mailhost.cs.auc.dk ([130.225.194.6]:9204 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S261186AbUCPSb3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 13:31:29 -0500
Subject: Problem with atkbd.c
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1079461752.24676.23.camel@rade7.s.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 19:29:12 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I noticed today that I got several time the following error log in my
/var/log/messages:

Mar 16 14:00:59 hermes vmunix: atkbd.c: Unknown key released (translated
set 2,
code 0x7a on isa0060/serio0).
Mar 16 14:00:59 hermes vmunix: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.
Mar 16 14:00:59 hermes vmunix: atkbd.c: Unknown key released (translated
set 2,
code 0x7a on isa0060/serio0).
Mar 16 14:00:59 hermes vmunix: atkbd.c: This is an XFree86 bug. It
shouldn't access hardware directly.

Is it a known bug ?

Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

