Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266165AbRF2TiU>; Fri, 29 Jun 2001 15:38:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266164AbRF2TiI>; Fri, 29 Jun 2001 15:38:08 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50840 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S266163AbRF2Thy>;
	Fri, 29 Jun 2001 15:37:54 -0400
Date: Fri, 29 Jun 2001 21:37:52 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106291937.VAA463690.aeb@vlet.cwi.nl>
To: jordan.breeding@inet.com, ledzep37@home.com
Subject: Re: USB Keyboard errors with 2.4.5-ac
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> is it totally hopeless to want to try and get a USB keyboard to work
> as the systems only keyboard and have it work under X
> and also not freeze the whole system when hitting certain keys?

I just tried, and everything works flawlessly here [2.4.6pre5].

In case you see strange things for some keys but not for others,
try finding out what the keycodes are (say, with showkey).

Andries
