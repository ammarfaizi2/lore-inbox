Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261241AbVCVN7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261241AbVCVN7T (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 08:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVCVN7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 08:59:19 -0500
Received: from mail-in-09.arcor-online.net ([151.189.21.49]:14749 "EHLO
	mail-in-09.arcor-online.net") by vger.kernel.org with ESMTP
	id S261241AbVCVN7N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 08:59:13 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: 2.6.11-rc4: Alps touchpad too slow
To: Andrew Morton <akpm@osdl.org>, Andy Isaacson <adi@hexapodia.org>,
       linux-kernel@vger.kernel.org, linux-input@atrey.karlin.mff.cuni.cz,
       Vojtech Pavlik <vojtech@suse.cz>
Reply-To: 7eggert@gmx.de
Date: Tue, 22 Mar 2005 15:03:53 +0100
References: <fa.fsi044a.12gkq90@ifi.uio.no> <fa.h4bjs27.mm8c1n@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <E1DDjz9-0000s9-8u@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> wrote:

> -             printk(KERN_INFO "  Enabling hardware tapping\n");
> +             printk(KERN_INFO "alps.c: Enabling hardware tapping\n");

I think these messages should be made for Admins, not developers.

s/alps.c/ALPS GlidePoint/ ?

