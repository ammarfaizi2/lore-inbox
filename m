Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129270AbRCENWz>; Mon, 5 Mar 2001 08:22:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129281AbRCENWp>; Mon, 5 Mar 2001 08:22:45 -0500
Received: from 4dyn174.delft.casema.net ([195.96.105.174]:7 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S129270AbRCENWi>; Mon, 5 Mar 2001 08:22:38 -0500
Message-Id: <200103051322.OAA31726@cave.bitwizard.nl>
Subject: Re: kmalloc() alignment
In-Reply-To: <E14ZuyF-00071y-00@the-village.bc.nu> from Alan Cox at "Mar 5, 2001
 01:24:13 pm"
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Mon, 5 Mar 2001 14:22:35 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>, Kenn Humborg <kenn@linux.ie>,
        Linux-Kernel <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> > As far as I know, you can count on 16-bytes alignment from
> > kmalloc. The trouble is that you would have to keep the original
> 
> Actually it depends on the debug settings

Actually THAT's a bug in the debug stuff.... 

		Roger.


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
