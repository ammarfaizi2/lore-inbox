Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271619AbRIGIlq>; Fri, 7 Sep 2001 04:41:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271620AbRIGIlg>; Fri, 7 Sep 2001 04:41:36 -0400
Received: from thebsh.namesys.com ([212.16.0.238]:43526 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S271619AbRIGIla>; Fri, 7 Sep 2001 04:41:30 -0400
Message-ID: <3B987C2E.DDDDAA0D@namesys.com>
Date: Fri, 07 Sep 2001 11:50:06 +0400
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Basic reiserfs question
In-Reply-To: <F45bR99kQgkV07DPT1p00005d9e@hotmail.com>
	 <3B97729B.1F49AACA@namesys.com> <20010907000239.26A738F91C@mail.delfi.lt>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nerijus Baliunas wrote:
> 
> On Thu, 06 Sep 2001 16:56:59 +0400 Hans Reiser <reiser@namesys.com> wrote:
> 
> HR> It seems that we should put something in journal replay that says:
> HR>
> HR> "Warning: replaying a non-empty journal, this means that either your system
> HR> crashed, or its shutdown scripts need fixing (a common distro failing at the
> HR> moment)
> 
> If you think it's RedHat, you probably are wrong - I use RH with reiserfs
> a long time (more than a year - 6.2, now 7.1), and never got a message about
> replaying journal if system was shut down correctly.
> 
> Regards,
> Nerijus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

I only have secondhand reports from users who patch RedHat boot scripts as
described at the end of www.namesys.com/faq.html, so your statement leaves me
puzzled as to whether the secondhand reports were from persons who didn't
understand the boot scripts.  Comments are welcome.

Hans
