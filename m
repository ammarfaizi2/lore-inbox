Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279229AbRJZVXR>; Fri, 26 Oct 2001 17:23:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279312AbRJZVXG>; Fri, 26 Oct 2001 17:23:06 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:59662 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S279229AbRJZVW4>; Fri, 26 Oct 2001 17:22:56 -0400
Subject: Re: 3Com PCI 3c905C Tornado with later kernels
To: kwijibo@zianet.com (Steven Spence)
Date: Fri, 26 Oct 2001 22:29:43 +0100 (BST)
Cc: sean@swallow.org (Sean Swallow), linux-kernel@vger.kernel.org
In-Reply-To: <3BD9BF74.4080400@zianet.com> from "Steven Spence" at Oct 26, 2001 01:54:28 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15xEXv-0001PU-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I believe it has somethin to do with RH scripts.  I just upgraded to 7.2 
> and I got
> the same crap.  I have the 3c982.  It didn't seem to affect much besides 
> not loading
> my eth0 correctly, but I just fixed that with ifconfig.

Most current distributions use netlink - make sure you have netlink sockets
in your custom build kernel and all should be well
