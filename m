Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTHTH44 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 03:56:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261761AbTHTH44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 03:56:56 -0400
Received: from pop.gmx.net ([213.165.64.20]:32661 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261756AbTHTH44 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 03:56:56 -0400
Message-Id: <5.2.1.1.2.20030820095103.019969f8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Wed, 20 Aug 2003 10:00:56 +0200
To: Voluspa <lista1@comhem.se>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O17int
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030820065515.059654d6.lista1@comhem.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 06:55 AM 8/20/2003 +0200, Voluspa wrote:

>Blender 2.28 can not starve xmms one iota. Within blender itself, I can
>cause 1 to 5 second freezes while doing a slow "world rotate", but that
>is something the application programmers have to fix.

I'm not so sure that it's an application bug.  With Nick's patch, I cannot 
trigger any delay what so ever, whereas with stock, or with Ingo's changes 
[as well as my own, damn the bad luck] I can.  I'm not saying it's _not_ a 
bug mind you, but color me suspicious ;-)

         -Mike 

