Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263806AbUC3SnL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 13:43:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263810AbUC3SnL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 13:43:11 -0500
Received: from 201008050033.user.veloxzone.com.br ([201.8.50.33]:47300 "EHLO
	pervalidus.dyndns.org") by vger.kernel.org with ESMTP
	id S263806AbUC3SnJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 13:43:09 -0500
Date: Tue, 30 Mar 2004 15:43:06 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: rmmod deadlocks with 2.6.5-rc[2,3]
Message-ID: <Pine.LNX.4.58.0403301529590.1233@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I boot with 2.6.5-rc[2,3] and use rmmod snd_via82xx or rmmod
ohci_hcd (it doesn't happen with all modules), rmmod deadlocks.
2.6.4 works fine.

-- 
http://www.pervalidus.net/contact.html
