Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266319AbSKUDqn>; Wed, 20 Nov 2002 22:46:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266335AbSKUDqn>; Wed, 20 Nov 2002 22:46:43 -0500
Received: from fmr01.intel.com ([192.55.52.18]:43504 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S266319AbSKUDqm>;
	Wed, 20 Nov 2002 22:46:42 -0500
Message-ID: <A46BBDB345A7D5118EC90002A5072C7806CAC974@orsmsx116.jf.intel.com>
From: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
To: "'Rusty Lynch'" <rusty@linux.co.intel.com>, linux-kernel@vger.kernel.org
Subject: RE: [Coding style question] XXX_register or register_XXX
Date: Wed, 20 Nov 2002 19:53:47 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> int foo_register(&something);
> int foo_unregister(&something);

I prefer this, althought the other one is [maybe more] common.

Inaky Perez-Gonzalez -- Not speaking for Intel - opinions are my own [or my
fault]
