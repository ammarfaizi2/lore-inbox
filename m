Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261351AbULXAlb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261351AbULXAlb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Dec 2004 19:41:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbULXAlb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Dec 2004 19:41:31 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:27028 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S261351AbULXAla (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Dec 2004 19:41:30 -0500
Subject: Re: apic and 8254 wraparound ...
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Ingo Molnar <mingo@redhat.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20041224001144.GA5192@mail.13thfloor.at>
References: <20041224001144.GA5192@mail.13thfloor.at>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1103845033.15193.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 23 Dec 2004 23:37:17 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2004-12-24 at 00:11, Herbert Poetzl wrote:
> I don't know what kind of errors the buggy Mercury/
> Neptune chipset timers can cause, maybe they need some
> special handling, but from the available code, what 
> about something like this:

Data sheet is on the intel site, but essentially latching bugs on the
reads.

