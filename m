Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262759AbSITPIb>; Fri, 20 Sep 2002 11:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262760AbSITPIb>; Fri, 20 Sep 2002 11:08:31 -0400
Received: from cpe-66-1-218-52.fl.sprintbbd.net ([66.1.218.52]:62989 "EHLO
	daytona.compro.net") by vger.kernel.org with ESMTP
	id <S262759AbSITPIa>; Fri, 20 Sep 2002 11:08:30 -0400
Message-ID: <3D8B3BDE.11C7E177@compro.net>
Date: Fri, 20 Sep 2002 11:16:46 -0400
From: Mark Hounschell <markh@compro.net>
Reply-To: markh@compro.net
Organization: Compro Computer Svcs.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-lcrs i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Booting problems with dual p4 on i860 chipset with 2.4 and 2.5
References: <20020920190537.A11244@namesys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> 
> Hello!
> 
>    We have a problem with newly acquired dual p4 xeon (2.2Ghz, heperthreading
>    blah blah) box built on i860 chipset (SuperMicro P4DC6+ motherboard).
>    Whenever we try to boot 2.4 or 2,5 kernel in there it decompresses
>    the kernel itself, states 'Ok, booting the kernel' and hangs.
>    We already tested these versions 2.4.15, 2.4.20-pre7, 2.4.18 from SuSE 8.0,
>    2.4.18 from RedHat 7.3 and latest RedHat beta (null), 2.5.36 (latest bk
>    snapshot as of now).
>    I remember I saw something like we experience now being reported on lkml
>    awhile back and 2.2 was able to boot in that case, so we tried 2.2.21
>    and it worked to our surprise.
>    We tried to install latest BIOS version available from MB manufacturer but
>    that did not help.
>    Unfortunatelly we are no longer able to find that mail with similar problems,
>    so may be someone have any ideas on what to do to get 2.4 (and 2.5)
>    up and runing on such a box?
> 
>    Thank you.
> 

I've got 6 of them here running SuSE 8.0. Hyperthreading was disabled in the
bios when Suse-8.0 was
installed and 3 of the 6 had the clock speed set at it's lowest setting when
they arrived but other than that there were no problems. HT was enabled after
the install of SuSE-8.0 and no problems there either. ?????

Mark
