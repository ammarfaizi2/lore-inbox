Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965250AbWADRpn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965250AbWADRpn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 12:45:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965251AbWADRpn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 12:45:43 -0500
Received: from mail.linicks.net ([217.204.244.146]:41906 "EHLO
	linux233.linicks.net") by vger.kernel.org with ESMTP
	id S965250AbWADRpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 12:45:42 -0500
From: Nick Warne <nick@linicks.net>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: 2.6.14.5 to 2.6.15 patch
Date: Wed, 4 Jan 2006 17:45:39 +0000
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org, "Randy.Dunlap" <rdunlap@xenotime.net>
References: <200601041710.37648.nick@linicks.net> <200601041728.52081.nick@linicks.net> <9a8748490601040940peb15b75n454e02a622f795e1@mail.gmail.com>
In-Reply-To: <9a8748490601040940peb15b75n454e02a622f795e1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601041745.39180.nick@linicks.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 04 January 2006 17:40, Jesper Juhl wrote:

> > I went from 2.6.14 -> 2.6.14.2 -> .2-.3 -> .3-.4 -> .4-.5
>
> If you did that you did it wrong. The -stable patches are *not*
> incremental, they all apply to the base 2.6.x kernel.

nick@linuxamd:kernel$ ls -lsa | grep patch

   24 -rw-r--r--   1 nick users    20572 2005-11-11 06:07 patch-2.6.14.2
   48 -rw-r--r--   1 nick users    46260 2005-11-24 22:15 patch-2.6.14.3
   24 -rw-r--r--   1 nick users    22725 2005-12-15 00:27 patch-2.6.14.3-4
   20 -rw-r--r--   1 nick users    18651 2005-12-27 00:29 patch-2.6.14.4-5

Nick
-- 
"Person who say it cannot be done should not interrupt person doing it."
-Chinese Proverb
My quake2 project:
http://sourceforge.net/projects/quake2plus/
