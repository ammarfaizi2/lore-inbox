Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTE0TPU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 May 2003 15:15:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264026AbTE0TPU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 May 2003 15:15:20 -0400
Received: from lindsey.linux-systeme.com ([80.190.48.67]:43014 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263986AbTE0TPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 May 2003 15:15:16 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH 2.4.21-rc4] Fix oom killer braindamage
Date: Tue, 27 May 2003 21:28:05 +0200
User-Agent: KMail/1.5.2
Cc: linux-kernel@vger.kernel.org
References: <200305272104.05802.m.c.p@wolk-project.de> <Pine.LNX.4.55L.0305271611410.9487@freak.distro.conectiva> <200305272118.29554.m.c.p@wolk-project.de>
In-Reply-To: <200305272118.29554.m.c.p@wolk-project.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200305272127.53355.m.c.p@wolk-project.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 May 2003 21:18, Marc-Christian Petersen wrote:

Hi again,

> > Not suitable for -rc. Btw, -rc5 is already at bkbits.net.
BTW: This breaks _nothing_. It _fixes_ an annoying bug! ;)

> well, not my fault ;-) Rik sent this while -pre time and after I saw it
> wasn't applied I sent it again while -pre time.

ciao, Marc

