Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261157AbUKHS1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261157AbUKHS1H (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Nov 2004 13:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbUKHSZI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Nov 2004 13:25:08 -0500
Received: from postman2.arcor-online.net ([151.189.20.157]:55222 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261156AbUKHSTH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Nov 2004 13:19:07 -0500
Date: Mon, 8 Nov 2004 19:18:32 +0100
From: Juergen Quade <quade@hsnr.de>
To: dtor_core@ameritech.net
Cc: LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [RFT/PATCH] Toshiba Satellite, Synaptics & keyboard problems
Message-ID: <20041108181832.GA26966@hsnr.de>
References: <200411080154.54279.dtor_core@ameritech.net> <20041108083531.GA17236@hsnr.de> <d120d50004110806334f69507c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <d120d50004110806334f69507c@mail.gmail.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ...
> Well, this one is pretty easy - make sure that you have a recent
> version of Synaptics X driver and change protocol in your XF86Config
> to "auto-dev". (most likely you wree using /dev/input/exentX as your
> device and in 2.6.9 your keyboard and touchpad swapped their
> event devices).

Gotcha!
Your guess was right. Thanks a lot!

          Juergen.
