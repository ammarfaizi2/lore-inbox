Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274035AbRI0WrW>; Thu, 27 Sep 2001 18:47:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274034AbRI0WrC>; Thu, 27 Sep 2001 18:47:02 -0400
Received: from femail43.sdc1.sfba.home.com ([24.254.60.37]:3487 "EHLO
	femail43.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S274031AbRI0Wqy>; Thu, 27 Sep 2001 18:46:54 -0400
Content-Type: text/plain; charset=US-ASCII
From: Nicholas Knight <tegeran@home.com>
Reply-To: tegeran@home.com
To: Luca Adesso <ladesso@libero.it>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Freeze
Date: Thu, 27 Sep 2001 15:47:18 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <5.1.0.14.2.20010928002445.00a4d5c0@popmail.libero.it>
In-Reply-To: <5.1.0.14.2.20010928002445.00a4d5c0@popmail.libero.it>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20010927224712.UFTU1138.femail43.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 27 September 2001 03:28 pm, Luca Adesso wrote:
> I have installed Linux (Slackware 8.0) on a Abit Pt5 with last bios.
> The kernel with that distribution is 2.4.5 and I'm trying to compile
> kernel 2.4.9 downloaded from kernel.org
> I already compiled that kernel on my notebook and it works fine, but
> everytime I reboot my p133 (the one with the abit) it freeze.
> It load the kernel and uncompress it and then... nothing!
>
> I tried to make a light kernel and a big kernel but... nothing.
>
> What can I do?
>

Check to ensure you're not compiling for a 686 or other chip 
family/revision above the capabilities of your processor (Processor 
Type and Features - XXX Processor Family where XXX is whatever is 
currently selected, select that and hit enter)
