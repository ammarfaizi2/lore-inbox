Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261498AbTCOTua>; Sat, 15 Mar 2003 14:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261502AbTCOTua>; Sat, 15 Mar 2003 14:50:30 -0500
Received: from air-2.osdl.org ([65.172.181.6]:43413 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S261498AbTCOTu3>;
	Sat, 15 Mar 2003 14:50:29 -0500
Message-ID: <33905.4.64.238.61.1047758480.squirrel@www.osdl.org>
Date: Sat, 15 Mar 2003 12:01:20 -0800 (PST)
Subject: Re: 2.5.64: menuconfig: help within choice blocks doesn't show?
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <mitch@theneteffect.com>
In-Reply-To: <200303151942.h2FJgwP19650@mako.theneteffect.com>
References: <200303151942.h2FJgwP19650@mako.theneteffect.com>
X-Priority: 3
Importance: Normal
Cc: <linux-kernel@vger.kernel.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've noticed the help text for menuconfig options doesn't show if it's
> inside a Kconfig choice block.  For example under "Processor type and
> features" -> "Processor family" none of the help shows for the processor
> types even though the help texts are present in the Kconfig file.
>
> Is anybody else seeing this?

Yes, same here.

~Randy



