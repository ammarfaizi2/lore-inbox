Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750802AbVIBSdK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750802AbVIBSdK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Sep 2005 14:33:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750809AbVIBSdJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Sep 2005 14:33:09 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:23984 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750802AbVIBSdI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Sep 2005 14:33:08 -0400
Subject: Re: IDE HPA
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Molle Bestefich <molle.bestefich@gmail.com>
Cc: ataraid-list@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <62b0912f05090210441d3fa248@mail.gmail.com>
References: <87941b4c05082913101e15ddda@mail.gmail.com>
	 <87941b4c05083008523cddbb2a@mail.gmail.com>
	 <1125419927.8276.32.camel@localhost.localdomain>
	 <87941b4c050830095111bf484e@mail.gmail.com>
	 <62b0912f0509020027212e6c42@mail.gmail.com>
	 <1125666332.30867.10.camel@localhost.localdomain>
	 <62b0912f05090206331d04afd3@mail.gmail.com>
	 <E1EBCdS-00064p-00@chiark.greenend.org.uk>
	 <62b0912f05090209242ad72321@mail.gmail.com>
	 <1125680712.30867.20.camel@localhost.localdomain>
	 <62b0912f05090210441d3fa248@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 02 Sep 2005 19:57:07 +0100
Message-Id: <1125687427.30867.23.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Gwe, 2005-09-02 at 19:44 +0200, Molle Bestefich wrote:
> The current default is causing grief because dmraid doesn't work, grub
> doesn't work and other userspace apps probably breaks too.  Users have
> to google and post to mailing lists just to get things to work (... if
> they could, which would require eg. a kernel option, but anyway).

You've show what - one obscure case with grub of an issue installers
already know about. dmraid is experimental anyway so submit fixes.

> The other way round, users would have to google to find the kernel
> option that claims the HPA area

And to find why their fs just choked, their computer no longer runs and
their files are lost. At which point they may not even be able to use
google.

