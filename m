Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263125AbTJBBvZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Oct 2003 21:51:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263153AbTJBBvZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Oct 2003 21:51:25 -0400
Received: from babyruth.hotpop.com ([204.57.55.14]:33686 "EHLO
	babyruth.hotpop.com") by vger.kernel.org with ESMTP id S263125AbTJBBvY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Oct 2003 21:51:24 -0400
Subject: Re: [PATCH] 2.6: joydev is too eager claiming input devices
From: Dan <overridex@punkass.com>
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Andrew Morton <akpm@osdl.org>, Dmitry Torokhov <dtor_core@ameritech.net>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20031001172723.GA32735@ucw.cz>
References: <1064459037.19555.3.camel@nazgul.overridex.net>
	 <200309250012.48522.dtor_core@ameritech.net>
	 <20030924232912.7e41d9f9.akpm@osdl.org>
	 <1064995829.14483.8.camel@nazgul.overridex.net>
	 <20031001172723.GA32735@ucw.cz>
Content-Type: text/plain
Message-Id: <1065059475.5391.2.camel@nazgul.overridex.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Wed, 01 Oct 2003 21:51:15 -0400
Content-Transfer-Encoding: 7bit
X-HotPOP: -----------------------------------------------
                   Sent By HotPOP.com FREE Email
             Get your FREE POP email at www.HotPOP.com
          -----------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-10-01 at 13:27, Vojtech Pavlik wrote:
> It's in test6. Does test6 work fine without Dmitry's fix?

Yep, seems to work fine without it. -Dan


