Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267555AbUI1GL3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267555AbUI1GL3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Sep 2004 02:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267558AbUI1GL3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Sep 2004 02:11:29 -0400
Received: from digitalimplant.org ([64.62.235.95]:57067 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S267555AbUI1GL2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Sep 2004 02:11:28 -0400
Date: Mon, 27 Sep 2004 23:11:20 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: "Zhu, Yi" <yi.zhu@intel.com>
cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       "" <linux-kernel@vger.kernel.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Oliver Neukum <oliver@neukum.org>
Subject: RE: suspend/resume support for driver requires an external firmware
In-Reply-To: <3ACA40606221794F80A5670F0AF15F8403BD57A2@pdsmsx403>
Message-ID: <Pine.LNX.4.50.0409272311090.24893-100000@monsoon.he.net>
References: <3ACA40606221794F80A5670F0AF15F8403BD57A2@pdsmsx403>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 28 Sep 2004, Zhu, Yi wrote:

> Do you still think the ->save_state, ->restore_state are the right
> approach

Yes.


	Pat
