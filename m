Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932214AbWDRLuY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932214AbWDRLuY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 07:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932215AbWDRLuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 07:50:24 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63715 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932214AbWDRLuW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 07:50:22 -0400
Subject: Re: Schedule for adding pata to kernel?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Fabio Comolli <fabio.comolli@gmail.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <b637ec0b0604180444y7828ac5aobb349324f87201c2@mail.gmail.com>
References: <1142869095.20050.32.camel@localhost.localdomain>
	 <4422F10B.9080608@bootc.net> <44266499.3070809@t-online.de>
	 <1143393969.2540.5.camel@localhost.localdomain>
	 <b637ec0b0604180444y7828ac5aobb349324f87201c2@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 18 Apr 2006 13:00:13 +0100
Message-Id: <1145361613.18736.44.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-04-18 at 13:44 +0200, Fabio Comolli wrote:
> In case PIIX/ICH driver should not make it in 2.6.17, are you planning
> to release patches for 2.6.17-rc release cycle?

I've been on holiday and am now tied up in other work until the start of
May, at which point Jeff goes off and gets married so there may be some
delay.

2.6.17-rc actually has 95% of the stuff needed to drop the PATA drivers
in and I will try to do patches at least versus 2.6.17 final. The -rcs
will depend upon available time and also what gets integrated that
causes additional work (notably Tejun Ho's stuff will make much merge
work, although its work I'm very glad to do as the improvements and
hotplug support are all needed).

Alan

