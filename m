Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262771AbTDAShg>; Tue, 1 Apr 2003 13:37:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262770AbTDAShf>; Tue, 1 Apr 2003 13:37:35 -0500
Received: from users.linvision.com ([62.58.92.114]:7565 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S262769AbTDAShe>; Tue, 1 Apr 2003 13:37:34 -0500
Date: Tue, 1 Apr 2003 20:48:50 +0200
From: Rogier Wolff <R.E.Wolff@BitWizard.nl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Craig Robinson <craig.robinson@btinternet.com>,
       linux-kernel-owner@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: 845GE Chipset severe performance problems
Message-ID: <20030401204850.A6890@bitwizard.nl>
References: <188481168784.20030329130300@btinternet.com> <1048949147.6725.3.camel@dhcp22.swansea.linux.org.uk> <153495685337.20030329170457@btinternet.com> <1049039985.14686.11.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1049039985.14686.11.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.3.22.1i
Organization: BitWizard.nl
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 30, 2003 at 04:59:46PM +0100, Alan Cox wrote:
> On Sat, 2003-03-29 at 17:04, Craig Robinson wrote:
> >  [/usr/src]# cat /proc/mtrr
> > reg00: base=0x00000000 (   0MB), size= 256MB: write-back, count=1
> > reg01: base=0x10000000 ( 256MB), size= 128MB: write-back, count=1
> > reg02: base=0x18000000 ( 384MB), size=  64MB: write-back, count=1
> > reg03: base=0x1c000000 ( 448MB), size=  32MB: write-back, count=1
> > reg04: base=0x1e000000 ( 480MB), size=  16MB: write-back, count=1
> > reg05: base=0x1f000000 ( 496MB), size=   8MB: write-back, count=1
> 
> Looks right for a machine with 504Mb of RAM. How does your box run
> if you boot with mem=504M ?

504Mb RAM? That sounds like a 512Mb ram with 8Mb "shared"
video-ram. 845? Sounds like one of those "everything integrated"
chipsets. performance problems? Do you happen to have the video in a
high-bandwidth mode?????

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2600998 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* The Worlds Ecosystem is a stable system. Stable systems may experience *
* excursions from the stable situation. We are currently in such an      * 
* excursion: The stable situation does not include humans. ***************
