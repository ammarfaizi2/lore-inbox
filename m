Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318241AbSGQLoK>; Wed, 17 Jul 2002 07:44:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318248AbSGQLoJ>; Wed, 17 Jul 2002 07:44:09 -0400
Received: from Hell.WH8.TU-Dresden.De ([141.30.225.3]:3815 "EHLO
	Hell.WH8.TU-Dresden.De") by vger.kernel.org with ESMTP
	id <S318241AbSGQLoI>; Wed, 17 Jul 2002 07:44:08 -0400
Message-ID: <3D355940.96EE8327@delusion.de>
Date: Wed, 17 Jul 2002 13:47:12 +0200
From: "Udo A. Steinberg" <reality@delusion.de>
Organization: Disorganized
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.26 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: PS2 Input Core Support
References: <3D35435F.E5CFA5E2@delusion.de> <20020717122000.A12529@ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vojtech Pavlik wrote:
> 
> It's a bug. This patch should fix it:

Hello,

With this patch I can now properly scroll down. But scrolling the
mouse wheel up doesn't do any scrolling up in X.

-Udo.
