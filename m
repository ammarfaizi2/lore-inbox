Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262035AbUD1Utm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262035AbUD1Utm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 16:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261418AbUD1UrG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 16:47:06 -0400
Received: from 200-170-96-180.ind.ajato.com.br ([200.170.96.180]:41826 "HELO
	qmail-out.velox.com.br") by vger.kernel.org with SMTP
	id S261421AbUD1UC6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 16:02:58 -0400
Date: Wed, 28 Apr 2004 17:00:21 -0300 (BRT)
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_L=2E_W=2E_Meunier?= <1@pervalidus.net>
To: linux-kernel@vger.kernel.org
Subject: TCP: Hash tables configured
Message-ID: <Pine.LNX.4.58.0404281657360.881@pervalidus.dyndns.org>
X-Archive: encrypt
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If I compile 2.4.x or 2.6.x with GCC 2.95.4 I see

TCP: Hash tables configured (established 32768 bind 32768)

If I instead use 3.3.3, I see

TCP: Hash tables configured (established 32768 bind 65536)

Is this expected ?

-- 
http://www.pervalidus.net/contact.html
