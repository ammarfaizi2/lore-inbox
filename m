Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbSKLNpl>; Tue, 12 Nov 2002 08:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266578AbSKLNpl>; Tue, 12 Nov 2002 08:45:41 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:10150 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266564AbSKLNpk>; Tue, 12 Nov 2002 08:45:40 -0500
Subject: Re: pc_keyb.c #define kbd_controller_present()
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Nat Ersoz <nat.ersoz@myrio.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1037069597.23521.46.camel@ersoz.et.myrio.com>
References: <1037069597.23521.46.camel@ersoz.et.myrio.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 12 Nov 2002 14:17:33 +0000
Message-Id: <1037110653.8321.5.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-12 at 02:53, Nat Ersoz wrote:
> Is it possible to get a new .config file symbol for the keyboard similar
> to the mouse?  It would be very helpful to us.

2.5 already has the ability to build a kernel without PS/2 keyboard. For
2.4 it wouldnt be hard. Cutting down the amount of noise and the time
waited might not be a bad idea too

