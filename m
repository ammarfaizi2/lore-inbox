Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267351AbTBVSn3>; Sat, 22 Feb 2003 13:43:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267353AbTBVSn3>; Sat, 22 Feb 2003 13:43:29 -0500
Received: from 12-252-67-253.client.attbi.com ([12.252.67.253]:31630 "EHLO
	morningstar.nowhere.lie") by vger.kernel.org with ESMTP
	id <S267351AbTBVSn2>; Sat, 22 Feb 2003 13:43:28 -0500
From: "John W. M. Stevens" <john@betelgeuse.us>
Date: Sat, 22 Feb 2003 11:53:29 -0700
To: Oleg Drokin <green@namesys.com>
Cc: thetech@folkwolf.net, linux-kernel@vger.kernel.org
Subject: Re: Box freezes if I enable "AMD 76x native power management"
Message-ID: <20030222185329.GA22170@morningstar.nowhere.lie>
References: <20030222163057.A884@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030222163057.A884@namesys.com>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 22, 2003 at 04:30:57PM +0300, Oleg Drokin wrote:
> Hello!
> 
>    Starting from 2.4.20 until now (including 2.4.21-pre4 and 2.4.21-pre4-ac5",
>    whenever I enable "AMD 76x native power management" in my kernel config, I get
>    kernel that hangs at boot after reporting elevator stuff about my IDE drives.
>    Is anybody interested?

I am.  This sounds suspiciously like the bug I reported.

But you haven't given quite enough information for me to compare.  Can
you send:

1) Exact Mother board (Tyan what?  Tiger MPX 2466N . . . ?)
2) Do you have DMA turned on for your IDE drives?
3) Are you enabling the AMD chip support for IDE?

. . . and anything else you can find out about the box?

Most importantly . . . does the problem go away if you turn off DMA
support for IDE?

Thanks,
John S.
