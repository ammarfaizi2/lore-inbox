Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267310AbUHIWQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267310AbUHIWQZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 18:16:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267311AbUHIWQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 18:16:25 -0400
Received: from mail.tpgi.com.au ([203.12.160.113]:20179 "EHLO mail.tpgi.com.au")
	by vger.kernel.org with ESMTP id S267310AbUHIWQY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 18:16:24 -0400
Subject: Re: [RFC] Fix Device Power Management States
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Patrick Mochel <mochel@digitalimplant.org>
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>, david-b@pacbell.net
In-Reply-To: <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
References: <Pine.LNX.4.50.0408090311310.30307-100000@monsoon.he.net>
	 <20040809113829.GB9793@elf.ucw.cz>
	 <Pine.LNX.4.50.0408090840560.16137-100000@monsoon.he.net>
Content-Type: text/plain
Message-Id: <1092089715.2859.1.camel@laptop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Tue, 10 Aug 2004 08:15:15 +1000
Content-Transfer-Encoding: 7bit
X-TPG-Antivirus: Passed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Tue, 2004-08-10 at 02:02, Patrick Mochel wrote:
> On Mon, 9 Aug 2004, Pavel Machek wrote:
> 
> > > - ->dev_stop() and ->dev_start() to struct class
> > >   This provides the framework to shutdown a device from a functional
> > >   level, rather than at a hardware level, as well as the entry points
> > >   to stop/start ALL devices in the system.

Looks good to me. That said, I'll keep my 'device_tree' patch while I
wait for this to get read for use.

Nigel

