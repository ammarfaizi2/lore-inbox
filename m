Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261329AbVGQRCj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261329AbVGQRCj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Jul 2005 13:02:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261332AbVGQRCj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Jul 2005 13:02:39 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:14997 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S261329AbVGQRCi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Jul 2005 13:02:38 -0400
Date: Sun, 17 Jul 2005 19:03:09 +0200 (CEST)
From: Bodo Eggert <7eggert@gmx.de>
To: Bodo Eggert <7eggert@gmx.de>
cc: akpm@osdl.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [1b/5+1] menu -> menuconfig part 1
In-Reply-To: <Pine.LNX.4.58.0507171326470.6041@be1.lrz>
Message-ID: <Pine.LNX.4.58.0507171902030.16515@be1.lrz>
References: <Pine.LNX.4.58.0507171311400.5931@be1.lrz>
 <Pine.LNX.4.58.0507171326470.6041@be1.lrz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-be10.7eggert.dyndns.org-MailScanner-Information: See www.mailscanner.info for information
X-be10.7eggert.dyndns.org-MailScanner: Found to be clean
X-be10.7eggert.dyndns.org-MailScanner-From: 7eggert@web.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Jul 2005, Bodo Eggert wrote:
> On Sun, 17 Jul 2005, Bodo Eggert wrote:

> > These patches change some menus into menuconfig options.
> > 
> > Reworked to apply to linux-2.6.13-rc3-git3
> 
> Mostly robotic works.

Fixup: unbreak i2c menu

-- 
Fun things to slip into your budget
Half a million dollars for consultants to design a web site that was being
done by an intern in his spare time.
