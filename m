Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271221AbTGPXUQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Jul 2003 19:20:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271248AbTGPXUP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Jul 2003 19:20:15 -0400
Received: from aneto.able.es ([212.97.163.22]:14979 "EHLO aneto.able.es")
	by vger.kernel.org with ESMTP id S271255AbTGPXTH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Jul 2003 19:19:07 -0400
Date: Thu, 17 Jul 2003 01:33:59 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.0-test1-ac2
Message-ID: <20030716233359.GE7263@werewolf.able.es>
References: <200307161816.h6GIGKH09243@devserv.devel.redhat.com> <20030716201339.GA618@sokrates> <1058392329.7677.1.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <1058392329.7677.1.camel@dhcp22.swansea.linux.org.uk>; from alan@lxorguk.ukuu.org.uk on Wed, Jul 16, 2003 at 23:52:10 +0200
X-Mailer: Balsa 2.0.12
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 07.16, Alan Cox wrote:
> On Mer, 2003-07-16 at 21:13, Michael Kristensen wrote:
> > Apropos emu10k1. Why is OSS deprecated? I have tried a little to get
> > ALSA working, but it doesn't seem to work. Hint?
> 
> ALSA has a lot more functionality than OSS and the API is better in many
> ways. The ALSA drivers dont have so much use and exposure so they will
> need time to shake down, but it should be worth it in the end.
> 

What I do not understand is why alsa has not gone into 2.4.
This will smooth transition to 2.6. Same as i2c. People starts using
alsa, then they switch to 2.6 and everything works.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.2 (Cooker) for i586
Linux 2.4.22-pre5-jam1m (gcc 3.3.1 (Mandrake Linux 9.2 3.3.1-0.2mdk))
