Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263284AbREaXsm>; Thu, 31 May 2001 19:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263285AbREaXsd>; Thu, 31 May 2001 19:48:33 -0400
Received: from mailhost.idcomm.com ([207.40.196.14]:23241 "EHLO
	mailhost.idcomm.com") by vger.kernel.org with ESMTP
	id <S263284AbREaXsO>; Thu, 31 May 2001 19:48:14 -0400
Message-ID: <3B16D852.91C5F2F1@idcomm.com>
Date: Thu, 31 May 2001 17:48:34 -0600
From: "D. Stimits" <stimits@idcomm.com>
Reply-To: stimits@idcomm.com
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-ac5-1 i686)
X-Accept-Language: en
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org
Subject: Re: missing sysrq
In-Reply-To: <E155aEF-0006VC-00@sites.inka.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bernd Eckenfels wrote:
> 
> In article <3B15EF16.89B18D@idcomm.com> you wrote:
> > However, if I go to /proc/sys/kernel/sysrq does not exist.
> 
> It is a compile time option, so the person who compiled your kernel left it
> out.

I compiled it, and the sysrq is definitely in the config. No doubt at
all. I also use make mrproper and config again before dep and actual
compile. Maybe it is just a quirk/oddball.

D. Stimits, stimits@idcomm.com

> 
> > vm.freepages = 383 766 1149
> 
> tat feature is removed in recent VM Systems.
> 
> Greetings
> Bernd
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
