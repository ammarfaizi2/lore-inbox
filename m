Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263792AbTKKWvD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 17:51:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263794AbTKKWvC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 17:51:02 -0500
Received: from [62.146.75.130] ([62.146.75.130]:63196 "EHLO mail.adebahr.de")
	by vger.kernel.org with ESMTP id S263792AbTKKWu7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 17:50:59 -0500
Date: Tue, 11 Nov 2003 23:50:57 +0100 (CET)
From: Peter Adebahr <adsys@adebahr.de>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23-pre9 ide+XFree+ptrace=Complete hang
In-Reply-To: <Pine.LNX.4.44.0311111849590.27840-100000@gaia.cela.pl>
Message-ID: <Pine.LNX.4.58.0311112344050.6924@siraly.adebahr.de>
References: <Pine.LNX.4.44.0311111849590.27840-100000@gaia.cela.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Nov 2003, Maciej Zenczykowski wrote:

> This is a very vague bug report... however this is something which
> definetely shouldn't be happening.  This is more a question as to whether
> such an issue is known and if not, how should I go about fixing it...

Hi Maciej,

I am also experiencing some strange hangups, without having had the
time to investigate them. Nothing in syslog, but a sure way NOT to
have problems: I have run all 2.4.23-pre kernels, and this has
definitely started with -pre7. Everything until -pre6 was fine.

My feeling tells me it has to do with DRM, so I built the -rc1-pac1
kernel about three hours ago, without any hickups so far.


Best regards from Hamburg, Germany.
Peter

