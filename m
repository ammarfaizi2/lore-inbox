Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276511AbRJCImy>; Wed, 3 Oct 2001 04:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276667AbRJCImp>; Wed, 3 Oct 2001 04:42:45 -0400
Received: from web13101.mail.yahoo.com ([216.136.174.146]:11529 "HELO
	web13101.mail.yahoo.com") by vger.kernel.org with SMTP
	id <S276511AbRJCImd>; Wed, 3 Oct 2001 04:42:33 -0400
Message-ID: <20011003084301.65322.qmail@web13101.mail.yahoo.com>
Date: Wed, 3 Oct 2001 01:43:01 -0700 (PDT)
From: szonyi calin <caszonyi@yahoo.com>
Subject: Re: [ANNOUNCE] Powertweak v0.99.4
To: Dave Jones <davej@suse.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011003014505.A7063@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Dave Jones <davej@suse.de> wrote:
> I just uploaded v0.99.4 (a bugfix only release) of
> Powertweak,
> the hardware configuration/tuning tool to
>
http://sourceforge.net/project/showfiles.php?group_id=253
> 
> v0.99.3 announced a few days ago had quite a few
> problems,
> which this release fixes. As well as those
> documented below
> there have been various fixes to get the code
> building on
> various strange glibc/gcc/autoconf's
> 
> This stands a much greater chance of working than
> the
> previous release, which I'll now pretend never
> happened.
> 
> 
> v0.99.4 [Release 22. -- The 'Bug Barbecue' release ]
> 
> - Bugfixes:
>   - 'Disk' Submenu works again.
>   - CPU backend cleanups.
>     - Was using memory after free()
>     - 'BrandName' field removed, and CPUName field
> improved.
>     - CPU Name can now be any length. 
>     - Now cleans identity structure prior to use. 
>   - hdparm backend got an overdue cleanup.
>     - tweaks no longer carry excess ioctl info.
>     - allocation routines made simpler.
>   - Only 'Tree' elements of the tree are now sorted.
> 
>   - When backends failed, we were dereferencing
> freed memory. 
>   - Sonypi backend now unloads if no Sonypi hardware
> present.
>   - PCI backend tried to read past byte 255 of
> config space.
> 														  
> 
> -- 
> | Dave Jones.                   
> http://www.codemonkey.org.uk
> | SuSE Labs .
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/


Hi 
I have an old Cx486 without PCI ?
Is there any use of Powertweak in this environement ?

Bye 

__________________________________________________
Do You Yahoo!?
Listen to your Yahoo! Mail messages from any phone.
http://phone.yahoo.com
