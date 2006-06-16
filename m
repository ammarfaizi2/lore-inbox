Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751057AbWFPGD1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751057AbWFPGD1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 02:03:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbWFPGD1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 02:03:27 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:28814 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1751057AbWFPGD1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 02:03:27 -0400
Message-ID: <449249AC.1000207@drzeus.cx>
Date: Fri, 16 Jun 2006 08:03:24 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To: dezheng shen <dzshen@winbond.com>
CC: Jesper Juhl <jesper.juhl@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       PI14 SJIN <SJin@winbond.com>
Subject: Re: [Winbond] flash memory reader SCSI device drivers [headers]
References: <448E875A.40805@winbond.com> 	<9a8748490606130258k60cdf429n89b1d1d017af60fe@mail.gmail.com> 	<448FC0C1.90205@winbond.com> <4491AEAC.5030606@drzeus.cx> <44920B22.4030507@winbond.com>
In-Reply-To: <44920B22.4030507@winbond.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

dezheng shen wrote:
>
>   Hmm, we might take this suggestion into consideration later. Right
> now, we would like to keep our current architecture for internal
> maintenance issues. The first thing we would like to do now is
> contributing our 518/528/528DA MS/MSPRO/xD/SM/SD/MMC and smart card
> drivers into Linux kernel source tree. There are, of course, many
> things can be improved in our codes. But at least we have run stree
> testing on many platforms from Intel 32/64 AMD 32/64 and single/dual
> configurations. We would like to contribute to kernel first then we
> can still update/modify/improve them later. Is that OK?

For testing, that should be fine. Note that it might not be accepted in
its current form though, so you'll probably have to put up a web site
where people can download patches for testing.

>
> ps. did  you get my email from linux-kernel? It seems like my emails
> to linux-kernel with my attachments are gone for no reason. Will that
> be my email size is over 100k?
>

Two of them got through. I don't know if that was all of them. For big
attachments you can always put them on a public web site and include
URL:s in the mail.

Rgds
Pierre

