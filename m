Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316632AbSFDTs6>; Tue, 4 Jun 2002 15:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316637AbSFDTs5>; Tue, 4 Jun 2002 15:48:57 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:44817 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S316632AbSFDTs4>; Tue, 4 Jun 2002 15:48:56 -0400
Message-ID: <3CFD19D1.5768FCF8@compro.net>
Date: Tue, 04 Jun 2002 15:49:37 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-64GB-SMP i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Michael Zhu <mylinuxk@yahoo.ca>
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Load kernel module automatically
In-Reply-To: <20020604193806.58478.qmail@web14905.mail.yahoo.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Zhu wrote:
> 
> Hi, I built a kernel module. I can load it into the
> kernle using insmod command. But each time when I
> reboot my computer I couldn't find it any more. I mean
> I need to use the insmod to load the module each time
> I reboot the computer. How can I modify the
> configuration so that the Linux OS can load my module
> automatically during reboot? I need to copy my module
> to the following directory?
>   /lib/modules/2.4.7-10/
> 
> I've done that. But it doesn't work.
> 
> Any help will be appreciated.

$man modules.conf

Mark
