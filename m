Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265806AbTBKCeZ>; Mon, 10 Feb 2003 21:34:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265815AbTBKCeY>; Mon, 10 Feb 2003 21:34:24 -0500
Received: from clem.clem-digital.net ([68.16.168.10]:15377 "EHLO
	clem.clem-digital.net") by vger.kernel.org with ESMTP
	id <S265806AbTBKCeX>; Mon, 10 Feb 2003 21:34:23 -0500
From: Pete Clements <clem@clem.clem-digital.net>
Message-Id: <200302110244.VAA24252@clem.clem-digital.net>
Subject: Re: 2.5.60 fails compile -- net/Space.c -- 3c509
In-Reply-To: <20030210173555.2c60eca2.akpm@digeo.com> from Andrew Morton at "Feb 10, 2003  5:35:55 pm"
To: akpm@digeo.com (Andrew Morton)
Date: Mon, 10 Feb 2003 21:42:46 -0500 (EST)
Cc: linux-kernel@vger.kernel.org (linux-kernel)
X-Mailer: ELM [version 2.4ME+ PL48 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Andrew Morton
  > 
  > Do you have a 3c509?  If so, can you test this?
  > 
Yes on the 3c509. Applied, compiles, boots and appears
happy. (not running as a module)

-- 
Pete Clements 
clem@clem.clem-digital.net
