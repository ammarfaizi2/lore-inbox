Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261806AbVAYE0I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261806AbVAYE0I (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 23:26:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261807AbVAYE0I
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 23:26:08 -0500
Received: from wproxy.gmail.com ([64.233.184.206]:14400 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261806AbVAYEZ6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 23:25:58 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=j1xtPADGP5ueFptgwrAhpiQkW1GlCJ8JQXkU3luwZ3vc72DRyTx6AujBpAv2xp5UGtvwVvyZSLXNp6u0m2gkzRMxYPmaeaIpBEGjDnsD131CrUzsc+/U7ENDsBSFzW63QqJZ8Q28DgL4loANNOl5HVjr1VMAErl+G1ooXqNeZq8=
Message-ID: <51a933b50501242025645ef27a@mail.gmail.com>
Date: Tue, 25 Jan 2005 09:55:55 +0530
From: Saravanan s <saravanan.mainker@gmail.com>
Reply-To: Saravanan s <saravanan.mainker@gmail.com>
To: Keith Owens <kaos@sgi.com>
Subject: Re: Announce: kdb v4.4 is available for kernel 2.6.10
Cc: kdb@oss.sgi.com, linux-kernel@vger.kernel.org, linux-ia64@vger.kernel.org
In-Reply-To: <14122.1106580892@ocs3.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <50C05B7AA7D6924FB5E384EF14BC647BC451EE@inba1mx2.corp.emc.com>
	 <14122.1106580892@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,

> I have no hardware to test on, so I have
> to rely on HP to keep the USB patches in KDB up to date. 

Does that mean that there is USB support for KDBv4.4 for kernel 2.6 
for i386 machines? Or the patch for i386 also comes from the HP guys.

Regards
Saravanan S

On Tue, 25 Jan 2005 02:34:52 +1100, Keith Owens <kaos@sgi.com> wrote:
> On Mon, 24 Jan 2005 15:21:08 -0000,
> gowda_avinash@emc.com wrote:
> >All:
> >I tried to get Kdb working on SuSe 9 ia64 box (kernel version
> >2.6.5-7.111.19). Turns out that the keyboard/machine goes into a hang state.
> >I have a usb keyboard!
> >
> >Googling around I found that Keith had disabled the USB keyboard support
> >some time back due to changes in some APIs (kernel version
> >linux-2.6.5-SLES9_SP1_BRANCH).
> >
> >Is this something that could be a cause for my problem? Should I think about
> >upgrading my kernel to 2.6.10 (hoping that the issue's been fixed in this
> >version)?
> 
> The USB keyboard support in KDB was written by HP, because their
> systems have USB keyboards.  I have no hardware to test on, so I have
> to rely on HP to keep the USB patches in KDB up to date.  That has not
> happened recently.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
