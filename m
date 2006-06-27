Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161107AbWF0PcA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161107AbWF0PcA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 11:32:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWF0PcA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 11:32:00 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:14087 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S1161107AbWF0Pb7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 11:31:59 -0400
Date: Tue, 27 Jun 2006 17:31:58 +0200
From: Adrian Bunk <bunk@stusta.de>
To: =?iso-8859-1?Q?P=E1draig?= Brady <P@draigBrady.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: util-linux status
Message-ID: <20060627153158.GB13915@stusta.de>
References: <44A13AFE.3080107@draigBrady.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <44A13AFE.3080107@draigBrady.com>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 03:04:46PM +0100, Pádraig Brady wrote:
> What is the status of util-linux?
> There doesn't seem to be anything significant
> released in about 1.5 years now.
> 
> I'm worried about patches getting lost,
> especially since there were a large number
> of thirdparty bugs/patches referenced in
> the changelog for 2004.
> 
> Personally I submitted a patch in 2004 that was
> merged immediately, then I sent a simple bug fix
> early in 2005 that has never been released.
>...
> This is the timeline over the last while as I see it:
> 
> 23 Sep 2005 ----------------------------------------2.12r
>   cfdisk: fix a segfault with ReiserFS partitions
>   umount: disallow -r option for non-root users
> 20 Jan 2005 ----------------------------------------2.12q
>   updated translations
> 01 Jan 2005 ----------------------------------------Maintainership change
> 23 Dec 2004 ----------------------------------------2.12p
>                            :
>                            : many changes in 16 versions
>                            :
> 05 Mar 2004 ----------------------------------------2.12a

What is missing in your timeline are the 2.13-pre releases that contain 
everything I've done.

But I know I have a big backlog of util-linux emails, and I hope having 
soon some spare time for handing them.

> Pádraig.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

