Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265422AbUEUIQ4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUEUIQ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 04:16:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265443AbUEUIQ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 04:16:56 -0400
Received: from host79.200-117-132.telecom.net.ar ([200.117.132.79]:3027 "EHLO
	smtp.bensa.ar") by vger.kernel.org with ESMTP id S265422AbUEUIQz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 04:16:55 -0400
From: Norberto Bensa <norberto+linux-kernel@bensa.ath.cx>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-mm4: missing symbol __log_start_commit in ext3.o
Date: Fri, 21 May 2004 05:16:56 -0300
User-Agent: KMail/1.6.2
Cc: Andrew Morton <akpm@osdl.org>, knobi@knobisoft.de,
       "Theodore Ts'o" <tytso@mit.edu>
References: <20040519151913.47070.qmail@web13906.mail.yahoo.com> <20040520145956.749567cb.akpm@osdl.org> <200405210512.16414.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200405210512.16414.norberto+linux-kernel@bensa.ath.cx>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200405210516.56989.norberto+linux-kernel@bensa.ath.cx>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:
> nbensa@venkman:~/linux-2.6.6-mm4$ patch -Rp1 < ../__log_start_commit.patch

                                           ^^^

Wrong -pX

Grrr.... I'm sorry; too late here. I better go to sleep.



Regards,
Norberto
