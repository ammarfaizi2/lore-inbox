Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261469AbULTHtc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261469AbULTHtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 02:49:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbULTHqf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 02:46:35 -0500
Received: from mx1.redhat.com ([66.187.233.31]:58278 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261469AbULTGic (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 01:38:32 -0500
Date: Sun, 19 Dec 2004 22:37:23 -0800
From: Pete Zaitcev <zaitcev@redhat.com>
To: Matthew Dharm <mdharm-kernel@one-eyed-alien.net>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: RFC: [2.6 patch] let BLK_DEV_UB depend on EMBEDDED
Message-ID: <20041219223723.3e861fc5@lembas.zaitcev.lan>
In-Reply-To: <20041220062055.GA22120@one-eyed-alien.net>
References: <20041220001644.GI21288@stusta.de>
	<20041220003146.GB11358@kroah.com>
	<20041220013542.GK21288@stusta.de>
	<20041219205104.5054a156@lembas.zaitcev.lan>
	<41C65EA0.7020805@osdl.org>
	<20041220062055.GA22120@one-eyed-alien.net>
Organization: Red Hat, Inc.
X-Mailer: Sylpheed-Claws 0.9.12cvs126.2 (GTK+ 2.4.14; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 19 Dec 2004 22:20:55 -0800, Matthew Dharm <mdharm-kernel@one-eyed-alien.net> wrote:

> I can tell you that this has turned into the single largest source of bug
> reports/complaints about usb-storage.  Something has to be done.  I just
> don't know what.

Is it that bad, really? Honestly, I could not imagine users can be so dumb.
The option defaults to off. There is a warning in the Kconfig. And yet they
first enable it and then complain about it. I don't know what to do about
it, either.

-- Pete
