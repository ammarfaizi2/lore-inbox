Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133097AbRDLK4p>; Thu, 12 Apr 2001 06:56:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133098AbRDLK4f>; Thu, 12 Apr 2001 06:56:35 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:20243 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S133097AbRDLK4V>; Thu, 12 Apr 2001 06:56:21 -0400
Subject: Re: 2.2.19: config help text about "TCO timer"
To: Ulrich.Windl@rz.uni-regensburg.de (Ulrich Windl)
Date: Thu, 12 Apr 2001 11:57:56 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3AD56F4C.17863.3AC6DD@localhost> from "Ulrich Windl" at Apr 12, 2001 09:03:05 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14nenX-0000Iz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I know TCO meaning that, but I can't believe it for a mainboard 
> component. Should the user then throw the PC away, or what? Or is it 
> more safe to reboot frequently. What has this to do with costs?

Its a watchdog timer. It reduces the <buzzword>TCO</buzzword> by letting you
arrange for your machine to reboot regularly if not poked. Its wonderful and
one of the reasons I deploy i815 motherboards with VIA processors (to avoid
the need for/regular failure of CPU fans) for remote servers.

Alan

