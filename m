Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264963AbSLHASk>; Sat, 7 Dec 2002 19:18:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264975AbSLHASk>; Sat, 7 Dec 2002 19:18:40 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:59837 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264963AbSLHASj>; Sat, 7 Dec 2002 19:18:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Arnd Bergmann <arnd@bergmann-dalldorf.de>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: s390 update.
Date: Sun, 8 Dec 2002 01:25:15 +0100
User-Agent: KMail/1.4.3
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, linux-kernel@vger.kernel.org,
       idrys@gmx.de
References: <200212061944.22688.schwidefsky@de.ibm.com> <200212062227.28464.arnd@bergmann-dalldorf.de> <20021207223007.GA4404@mars.ravnborg.org>
In-Reply-To: <20021207223007.GA4404@mars.ravnborg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212080125.16019.arnd@bergmann-dalldorf.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 07 December 2002 23:30, Sam Ravnborg wrote:

> +makeboot =$(Q)$(MAKE) -f script/Makefile.build obj=arch/$(ARCH)/boot $(1)
				^^^^
That needs to be 'scripts', the rest is ok. I'll put it in our tree.
Thanks!

	Arnd <><
