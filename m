Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbTE0TUT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:20:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264087AbTE0TUT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:20:19 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:7838 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S264085AbTE0TUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:20:17 -0400
Date: Tue, 27 May 2003 16:31:33 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
X-X-Sender: marcelo@freak.distro.conectiva
To: Marc-Christian Petersen <m.c.p@wolk-project.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.21-rc4] Fix oom killer braindamage
In-Reply-To: <200305272127.53355.m.c.p@wolk-project.de>
Message-ID: <Pine.LNX.4.55L.0305271631020.9487@freak.distro.conectiva>
References: <200305272104.05802.m.c.p@wolk-project.de>
 <Pine.LNX.4.55L.0305271611410.9487@freak.distro.conectiva>
 <200305272118.29554.m.c.p@wolk-project.de> <200305272127.53355.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 27 May 2003, Marc-Christian Petersen wrote:

> On Tuesday 27 May 2003 21:18, Marc-Christian Petersen wrote:
>
> Hi again,
>
> > > Not suitable for -rc. Btw, -rc5 is already at bkbits.net.
> BTW: This breaks _nothing_. It _fixes_ an annoying bug! ;)

You're not completly sure it doesnt break nothing. MM/VM can be reallly
subtle and nasty at times.
