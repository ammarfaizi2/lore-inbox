Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752001AbWFLOUU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbWFLOUU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 10:20:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752003AbWFLOUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 10:20:19 -0400
Received: from admin.zirkelwireless.com ([209.216.203.65]:63634 "EHLO
	admin.zirkelwireless.com") by vger.kernel.org with ESMTP
	id S1752001AbWFLOUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 10:20:18 -0400
Subject: Re: [Linux-fbdev-devel] [PATCH 0/7] Detaching fbcon
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@tungstengraphics.com>
To: linux-fbdev-devel@lists.sourceforge.net
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
References: <44856223.9010606@gmail.com> <448C19D7.5010706@t-online.de>
	 <448C83AD.9060200@gmail.com> <448D1C9E.7050606@t-online.de>
	 <448D5B4F.5080504@gmail.com>
	 <a5d587fb0606120628o203941c3h761bfffbb6ec08f7@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Organization: Tungsten Graphics
Date: Mon, 12 Jun 2006 16:20:11 +0200
Message-Id: <1150122011.5693.17.camel@thor.lorrainebruecke.local>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-06-12 at 15:28 +0200, Michal Suchanek wrote:
> 
> I like the possibility to change X resolution using fbset (from inside
> X). I use it to correct problems caused by crashed X programs that
> change resolution. But I run X with the UseFbDev option.

Still, you should use something like xrandr instead, so the X server
knows about it.


-- 
Earthling Michel Dänzer           |          http://tungstengraphics.com
Libre software enthusiast         |          Debian, X and DRI developer


