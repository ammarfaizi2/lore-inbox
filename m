Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbULFRNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbULFRNH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Dec 2004 12:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261573AbULFRMp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Dec 2004 12:12:45 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:31947 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261566AbULFRMh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Dec 2004 12:12:37 -0500
Subject: Re: [PATCH] ATA over Ethernet driver for 2.6.9
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ed L Cashin <ecashin@coraid.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <87sm6jpe8o.fsf@coraid.com>
References: <87acsrqval.fsf@coraid.com>
	 <Pine.LNX.4.58.0412061027510.2173@gradall.private.brainfood.com>
	 <87sm6jpe8o.fsf@coraid.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1102349345.14484.5.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 06 Dec 2004 16:09:06 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-12-06 at 16:45, Ed L Cashin wrote:
> >> (We also have an AoE driver for the 2.4 kernel that we plan to release
> >> soon.)
> >
> > Is there a free server for this?
> 
> Are you asking whether anybody has written software that allows a
> network host to export block storage using AoE?  Not yet, as far as I
> know.

I wrote a very bad one for the original protocol draft when playing with
this stuff some time ago. I'm not sure its actually worth ressurecting.
It's pretty trivial to write but ATAoE is rather more interesting in the
context of microcontroller on ethernet than the PC side.


