Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262038AbUKJThl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbUKJThl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 14:37:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262115AbUKJTgm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 14:36:42 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:64209 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262110AbUKJTdi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 14:33:38 -0500
Subject: Wanted: small number of crazy highpoint IDE  (HPT366-372N/374)
	controller owners
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-ide@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1100111436.20556.15.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 10 Nov 2004 18:30:36 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've been debugging and chasing down various HPT IDE problems. I've done
some cleanups, fixed the PLL tune and little bits like that. These are
the kind of changes that turn your disk into a random number generator
if they go wrong but OTOH the HPT372N crashes should be fixed.

Now it needs some testers...

Alan

