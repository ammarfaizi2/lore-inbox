Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261198AbVALOfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261198AbVALOfW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 09:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261199AbVALOfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 09:35:22 -0500
Received: from bernache.ens-lyon.fr ([140.77.167.10]:59554 "EHLO
	bernache.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261198AbVALOfS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 09:35:18 -0500
Message-ID: <41E535A4.5010309@ens-lyon.fr>
Date: Wed, 12 Jan 2005 15:35:16 +0100
From: Brice Goglin <Brice.Goglin@ens-lyon.fr>
Reply-To: Brice.Goglin@ens-lyon.org
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: dtor_core@ameritech.net
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc1
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org>	 <41E4DEBB.90606@ens-lyon.fr> <20050112092042.GA27528@dose.home.local>	 <41E4F010.9090305@ens-lyon.fr> <d120d500050112061348443e1f@mail.gmail.com>
In-Reply-To: <d120d500050112061348443e1f@mail.gmail.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Report: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dmitry Torokhov a écrit :
> On Wed, 12 Jan 2005 10:38:24 +0100, Brice Goglin
>>>>puligny:~# setkeycodes e023 150 e01e 155 e01a 217 e01f 157
>>>>KDSETKEYCODE: No such device
>>>>failed to set scancode a3 to keycode 150
> 
> Please try the patch from here:
> http://marc.theaimsgroup.com/?l=linux-kernel&m=110430679525030&w=2
> 
> Vojtech said he'd push it and some more stuff to Linus...

Yes it works. Thanks.

Brice
