Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbUJaBP6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbUJaBP6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Oct 2004 21:15:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261461AbUJaBP6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Oct 2004 21:15:58 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:21994 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S261459AbUJaBP4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Oct 2004 21:15:56 -0400
Message-ID: <41843E10.1040800@comcast.net>
Date: Sat, 30 Oct 2004 18:21:20 -0700
From: Z Smith <plinius@comcast.net>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: code bloat [was Re: Semaphore assembly-code bug]
References: <417550FB.8020404@drdos.com.suse.lists.linux.kernel>	 <200410310111.07086.vda@port.imtp.ilyichevsk.odessa.ua>	 <20041030222720.GA22753@hockin.org>	 <200410310213.37712.vda@port.imtp.ilyichevsk.odessa.ua> <1099176319.25194.10.camel@localhost.localdomain>
In-Reply-To: <1099176319.25194.10.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> So if the desktop stuff is annoying you join gnome-love or whatever the
> kde equivalent is 8)

Or join me in my effort to limit bloat. Why use an X server
that uses 15-30 megs of RAM when you can use FBUI which is 25 kilobytes
of code with very minimal kmallocing?

home.comcast.net/~plinius/fbui.html

Zack Smith
Bloat Liberation Front

