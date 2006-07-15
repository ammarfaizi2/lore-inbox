Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946022AbWGOLac@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946022AbWGOLac (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Jul 2006 07:30:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946027AbWGOLac
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Jul 2006 07:30:32 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:42146 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1946022AbWGOLab (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Jul 2006 07:30:31 -0400
Subject: Re: oops in bttv
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Alex Riesen <fork0@users.sourceforge.net>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       v4l-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com
In-Reply-To: <20060711204940.GA11497@steel.home>
References: <20060711204940.GA11497@steel.home>
Content-Type: text/plain; charset=ISO-8859-1
Date: Sat, 15 Jul 2006 08:29:53 -0300
Message-Id: <1152962993.26522.18.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.7.2.1-4mdv2007.0 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2006-07-11 às 22:49 +0200, Alex Riesen escreveu:
> What I did was to call settings of the flashplayer and press on the
> webcam symbol there. The system didn't crash, just this oops:
> 
> BUG: unable to handle kernel NULL pointer dereference at virtual address 0000006
> 5
Hmm... Are you using it on what machine? It might be related to an
improper handling at compat32 module.

Cheers,
Mauro.

