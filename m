Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261679AbRFGP7X>; Thu, 7 Jun 2001 11:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbRFGP7O>; Thu, 7 Jun 2001 11:59:14 -0400
Received: from hera.cwi.nl ([192.16.191.8]:36046 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S261679AbRFGP7F>;
	Thu, 7 Jun 2001 11:59:05 -0400
Date: Thu, 7 Jun 2001 17:59:02 +0200 (MET DST)
From: Andries.Brouwer@cwi.nl
Message-Id: <UTC200106071559.RAA212142.aeb@vlet.cwi.nl>
To: Andries.Brouwer@cwi.nl, olh@suse.de
Subject: Re: 2.4.5-ac9 console NULL pointer pointer dereference
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> INIT: Id "1" respawning too fast: disabled for 5 minutes

> Any ideas?

Instead of asking the world, why not read the man page?
If inittab has mingetty, then the man page says:

  Unlike agetty(8), mingetty  is  not  suitable  for  serial lines.

Andries
