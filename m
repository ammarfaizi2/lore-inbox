Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264411AbTLKXar (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Dec 2003 18:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264414AbTLKXar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Dec 2003 18:30:47 -0500
Received: from massena-4-82-67-197-146.fbx.proxad.net ([82.67.197.146]:62593
	"EHLO perso.free.fr") by vger.kernel.org with ESMTP id S264411AbTLKXap
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Dec 2003 18:30:45 -0500
From: Duncan Sands <baldrick@free.fr>
To: Oliver Neukum <oliver@neukum.org>, Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [linux-usb-devel] Re: [OOPS,  usbcore, releaseintf] 2.6.0-test10-mm1
Date: Fri, 12 Dec 2003 00:30:44 +0100
User-Agent: KMail/1.5.4
Cc: David Brownell <david-b@pacbell.net>, Vince <fuzzy77@free.fr>,
       "Randy.Dunlap" <rddunlap@osdl.org>, <mfedyk@matchmail.com>,
       <zwane@holomorphy.com>, <linux-kernel@vger.kernel.org>,
       USB development list <linux-usb-devel@lists.sourceforge.net>
References: <Pine.LNX.4.44L0.0312081754480.2034-100000@ida.rowland.org> <200312112243.37328.baldrick@free.fr> <200312112357.15661.oliver@neukum.org>
In-Reply-To: <200312112357.15661.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312120030.44051.baldrick@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Why then is dev->serialize not taken in usb_reset_device
> (except in a dud code path)?

And this one?  Surely usb_reset_device changes configurations
etc...

Thanks,

Duncan.
