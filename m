Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266279AbUALVQo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jan 2004 16:16:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266284AbUALVQn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jan 2004 16:16:43 -0500
Received: from 204.Red-213-96-224.pooles.rima-tde.net ([213.96.224.204]:18438
	"EHLO betawl.net") by vger.kernel.org with ESMTP id S266279AbUALVOr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jan 2004 16:14:47 -0500
Date: Mon, 12 Jan 2004 22:14:44 +0100
From: Santiago Garcia Mantinan <manty@manty.net>
To: Rene Herman <rene.herman@keyaccess.nl>
Cc: Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org,
       Adam Belay <ambx1@neo.rr.com>
Subject: Re: [PATCH] Re: ALSA in 2.6 failing to find the OPL chip of the sb cards
Message-ID: <20040112211443.GA1574@man.manty.net>
References: <20040107212916.GA978@man.manty.net> <s5hy8sixsor.wl@alsa2.suse.de> <20040109171715.GA933@man.manty.net> <s5hn08xgh06.wl@alsa2.suse.de> <20040109201423.GA1677@man.manty.net> <3FFFA8C3.6040609@keyaccess.nl> <4000E030.2020500@keyaccess.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4000E030.2020500@keyaccess.nl>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The attached patch works for me:

Yes, your patch made my sb16pnp fully work again.

Thanks!

Regards...
-- 
Manty/BestiaTester -> http://manty.net
