Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268028AbUHVQzm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268028AbUHVQzm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 12:55:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268029AbUHVQzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 12:55:42 -0400
Received: from mazurek.man.lodz.pl ([212.51.192.15]:12933 "EHLO
	mazurek.man.lodz.pl") by vger.kernel.org with ESMTP id S268028AbUHVQzh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 12:55:37 -0400
Date: Sun, 22 Aug 2004 18:55:29 +0200 (CEST)
From: Piotr Goczal <bilbo@mazurek.man.lodz.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: Promise Fast Track SX6000 i2o driver.
In-Reply-To: <1093184419.24617.5.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.58.0408221854310.2571@mazurek.man.lodz.pl>
References: <Pine.LNX.4.58.0408211012500.2571@mazurek.man.lodz.pl> 
 <1093173914.24272.45.camel@localhost.localdomain> 
 <Pine.LNX.4.58.0408221606520.2571@mazurek.man.lodz.pl>
 <1093184419.24617.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-mazurek.man.lodz.pl-MailScanner-Information: Please contact bilbo@man.lodz.pl
X-mazurek.man.lodz.pl-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 22 Aug 2004, Alan Cox wrote:

> As I understand it the new firmware isn't I2O so I2O would be the wrong
> driver anyway. If Promise own source code drivers support it then that
> is at least as good as documentation 8). Are promise own drivers for the
> sx6000 GPL or not ?

Fortunatelly: YES

[bilbo@pc-bilbo st6000src_1.34]$ more pti_st.c
/*+M*************************************************************************
 * Promise SuperTrak device driver for Linux.
 *
 * Copyright (c) 2001  Promise Technology, Inc.
 *
 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  
USA
 *
 * 
--------------------------------------------------------------------------
 * Copyright (c) 1999-2001 Promise Technology, Inc.
 * All rights reserved.

Regards

Piotr Goczal
