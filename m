Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271915AbTGRWjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 18:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271914AbTGRWje
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 18:39:34 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:17670 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S271925AbTGRWii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 18:38:38 -0400
Subject: Re: [PATCH] O7int for interactivity
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Mike Galbraith <efault@gmx.de>,
       Davide Libenzi <davidel@xmailserver.org>
In-Reply-To: <200307190210.49687.kernel@kolivas.org>
References: <200307190210.49687.kernel@kolivas.org>
Content-Type: text/plain
Message-Id: <1058568811.602.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 
Date: 19 Jul 2003 00:53:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-07-18 at 18:10, Con Kolivas wrote:
> Here is an update to my Oint patches for 2.5/6 interactivity. Note I will be 
> away for a week so bash away and abuse this one lots and when I get back I can 
> see what else needs doing. Note I posted a preview earlier but this is the formal
> O7 patch (check the datestamp which people hate in the naming of my patches).
> I know this is turning into a marathon effort but... as you're all probably aware
> there is nothing simple about tuning this beast. Thanks to all the testers and
> people commenting; keep it coming please.

Feels pretty nice here... X still feels a little "heavy" and slow when
forcing Evolution to repaint its main window. Anyways, this seems to be
on the right track.

