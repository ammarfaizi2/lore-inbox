Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbSLJWQG>; Tue, 10 Dec 2002 17:16:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbSLJWQG>; Tue, 10 Dec 2002 17:16:06 -0500
Received: from irongate.swansea.linux.org.uk ([194.168.151.19]:14017 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S266712AbSLJWQF>; Tue, 10 Dec 2002 17:16:05 -0500
Subject: Re: new driver to replace LMC
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: david linux <davidslinuxpob@yahoo.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20021210183330.37724.qmail@web14602.mail.yahoo.com>
References: <20021210183330.37724.qmail@web14602.mail.yahoo.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 10 Dec 2002 20:55:41 +0000
Message-Id: <1039553862.14251.62.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-12-10 at 18:33, david linux wrote:
> I'd be happy to submit the new driver (at least the
> replacement for the stale stuff being passed around)
> to be wrapped in new kernel versions ... but I don't
> know who would be best to write re this subject.

The core maintainers are
	Linus Torvalds for 2.5
	Marcelo Tosatti for 2.4
	Alan Cox (me) for 2.2

For 2.2 I prefer to take only minimal bug fixes since its designed to be
as stable as humanly possible.

