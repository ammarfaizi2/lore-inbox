Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266582AbUITOQF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266582AbUITOQF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 10:16:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUITOQF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 10:16:05 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:51415 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266582AbUITOQA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 10:16:00 -0400
Subject: Re: WRT54G
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Aiko Barz <aiko@chroot.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20040919095857.GD17602@lain.chroot.de>
References: <20040919095857.GD17602@lain.chroot.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1095686020.26647.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 20 Sep 2004 14:13:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-09-19 at 10:58, Aiko Barz wrote:
> Hi there!
> 
> It's the wrt54g subject again...
> I'm mirroring the Sveasoft-firmware, which was published under the
> terms of "GPL". At least Sveasoft said that. 

Can you prove they said that ?

> This site http://www.linksys.com/support/gpl.asp also implies, that i
> can redistribute those drivers and firmwares. But it is the same
> problem with them. Those wrt54g-firmwares also contain non-GPL
> sourcecodes and binaries.

It's up to Linksys what license they grant you for their non-free stuff.
If its linked with GPL stuff then it might be GPL because its a
derivative work. Sveasoft's only business is code they own the copyright
to themselves and didn't give other people rights to redistribute (or
gave them specifically revokable rights to distribute)

> Sveasoft is hunting down mirrorsites right now. Of course, they want
> to earn some money. So i'm not sure what I should do next?!
> Going down or asking for the rest of the code?

That depends what they said about the code and what you can prove about
it. Sveasoft's evil claws extend only to code they themselves own
copyright to and have not already granted things like GPL rights too (or
any other irrevocable right). 

It highlights the dangers of relying on a partially proprietary software
stack, as well as why Richard Stallman always asks vendors of Linux and
other free software products that if they also bundle non-free software
it is easy to tell which is which. Hence Debian has a seperate non-free
archive, Fedora is open source only but there are third party yum
repositories for non-free products and so on.

Alan

