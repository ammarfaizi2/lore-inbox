Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261592AbULCXgr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261592AbULCXgr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Dec 2004 18:36:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262507AbULCXgr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Dec 2004 18:36:47 -0500
Received: from rosebud.otenet.gr ([195.170.0.26]:9959 "EHLO rosebud.otenet.gr")
	by vger.kernel.org with ESMTP id S261592AbULCXgp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Dec 2004 18:36:45 -0500
Message-Id: <200412032336.iB3NaiCk027949@rosebud.otenet.gr>
From: "Nicholas Papadakos" <panic@quake.gr>
To: <linux-kernel@vger.kernel.org>
Subject: RE: realtek r8169 + kernel 2.4.24 (openmosix)
Date: Fri, 3 Dec 2004 23:29:31 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Thread-Index: AcTZfvgW2RZVIofgQc2R2dbY4hAn2AAACpsg
In-Reply-To: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,
I am trying to use a realtek r8169 gigabit Ethernet levelone card as a link
between two machines that are cluster using openmosix, However whenever I
try to transfer large amounts of data after 5 secs the connections freezes.
I found a similar older post with an attacked patch to try, I tried it but
the problem remained. Any help ?
I don't want to upgrade kernel to something else as I need openmosix to keep
running.

Regards,
Nicholas Papadakos

