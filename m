Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264917AbUBCAMn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 19:12:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265200AbUBCAMn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 19:12:43 -0500
Received: from d235-143-242.home1.cgocable.net ([24.235.143.242]:36858 "EHLO
	ns1.emaildesktop.com") by vger.kernel.org with ESMTP
	id S264917AbUBCAMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 19:12:37 -0500
Message-ID: <002601c3e9ea$7968db80$0201a8c0@wksdan>
From: "Dan McGrath" <troubled@emaildesktop.com>
To: <linux-kernel@vger.kernel.org>
Subject: Tape backups cant be read read using crypto loop
Date: Mon, 2 Feb 2004 19:12:56 -0500
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

Hello,

I have a few DDS2 tape backups of my ripped CD's in mp3 format. I noticed
that under 2.4.24 with loop-jari patch, I cant read them when I enable
crypto loop support. I found disabling it works fine. Just curious if this
problem is the same in 2.6.x or if anyone has noticed that its broken for
old tape backups.

Its not a big deal I guess, I can always just remake the tape with crypto
loop enabled and things seem fine, just thought I would share and see what
everyone has to say. Thanks guys.


troubled


