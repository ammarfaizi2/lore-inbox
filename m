Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263577AbUDMTZc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 15:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263695AbUDMTZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 15:25:32 -0400
Received: from adsl-67-65-232-1.dsl.lgvwtx.swbell.net ([67.65.232.1]:53388
	"HELO rooker.dyndns.org") by vger.kernel.org with SMTP
	id S263577AbUDMTZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 15:25:29 -0400
Message-ID: <004c01c4218c$eb9e61a0$6600a8c0@pixl>
From: "Peter Maas" <peter@goquest.com>
To: <linux-kernel@vger.kernel.org>
Subject: RE: 2.6.5-mm5-1 ACCRAID dies under heavy io load
Date: Tue, 13 Apr 2004 14:24:20 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hmm, after more testing, heavy io load isnt necessary to kill accraid, it
appears to be dying randomly.

peter

