Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261506AbTEMPYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 May 2003 11:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbTEMPYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 May 2003 11:24:47 -0400
Received: from smtpzilla3.xs4all.nl ([194.109.127.139]:52741 "EHLO
	smtpzilla3.xs4all.nl") by vger.kernel.org with ESMTP
	id S261506AbTEMPYn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 May 2003 11:24:43 -0400
Date: Tue, 13 May 2003 17:35:51 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@serv
To: David Brownell <david-b@pacbell.net>
cc: Greg KH <greg@kroah.com>, Adrian Bunk <bunk@fs.tum.de>,
       <linux-kernel@vger.kernel.org>
Subject: Re: 2.5.69-bk7: multiple definition of `usb_gadget_get_string'
In-Reply-To: <3EC03705.8040100@pacbell.net>
Message-ID: <Pine.LNX.4.44.0305131733180.12110-100000@serv>
References: <20030512205848.GU1107@fs.tum.de> <20030512211159.GA29716@kroah.com>
 <3EC03705.8040100@pacbell.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 12 May 2003, David Brownell wrote:

> Seems like the xconfig/menuconfig coredumps I previously
> saw with tristate choice/endchoice are now gone ... or at
> least they don't show up with this many choices!

There might be problems with choices, which have no visible values, I'll 
have to check this.
Please report such problems, otherwise I can't fix them.

bye, Roman

