Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261369AbTCZD7t>; Tue, 25 Mar 2003 22:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262754AbTCZD7s>; Tue, 25 Mar 2003 22:59:48 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:27661
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S261369AbTCZD7r>; Tue, 25 Mar 2003 22:59:47 -0500
Subject: Re: [PATCH] Logitech USB mice/trackball extensions
From: Robert Love <rml@tech9.net>
To: Eric Wong <eric@yhbt.net>
Cc: Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030326022938.GA5187@bl4st.yhbt.net>
References: <20030326022938.GA5187@bl4st.yhbt.net>
Content-Type: text/plain
Organization: 
Message-Id: <1048651849.1486.451.camel@phantasy.awol.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 25 Mar 2003 23:10:49 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-03-25 at 21:29, Eric Wong wrote:
> This patch adds support for controlling 400/800 cpi resolution and
> SMS/Smart Scroll/Cruise control for certain Logitech mice.  Disabling
> SMS lets you use the extra buttons on MX500/700 as regular buttons if
> an application supports evdev since ExpPS/2 doesn't support all the
> buttons.

Cool :)

For those of us not using modules, any chance of making these available
via some runtime mechanism (sysfs, perhaps)?

Also, have you looked into what it takes to read the battery from either
the wireless mouseman or the MX700?  I recently ditched my MX700 for an
MX500, as the battery life was awful after a few months... but I think
it would be a nice feature nonetheless.

Good work,

	Robert Love

