Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131479AbRD2UEL>; Sun, 29 Apr 2001 16:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136156AbRD2UDw>; Sun, 29 Apr 2001 16:03:52 -0400
Received: from 13dyn119.delft.casema.net ([212.64.76.119]:53765 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S131479AbRD2UDs>; Sun, 29 Apr 2001 16:03:48 -0400
Message-Id: <200104292003.WAA25179@cave.bitwizard.nl>
Subject: Re: Sony Memory stick format funnies...
In-Reply-To: <9cflov$fdv$1@cesium.transmeta.com> from "H. Peter Anvin" at "Apr
 28, 2001 05:03:43 pm"
To: "H. Peter Anvin" <hpa@zytor.com>
Date: Sun, 29 Apr 2001 22:03:40 +0200 (MEST)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

H. Peter Anvin wrote:
> Followup to:  <200104282236.AAA06021@cave.bitwizard.nl>
> By author:    R.E.Wolff@BitWizard.nl (Rogier Wolff)
> In newsgroup: linux.dev.kernel
> > 
> > # l /mnt/d1
> > total 16
> > drwxr-xr-x 512 root     root        16384 Mar 24 17:26 dcim/
> > -r-xr-xr-x   1 root     root            0 May 23  2000 memstick.ind*
> > # 
> > 
> > Where the *(&#$%& does that "dcim" directory come from????
> > 
> 
> "dcim" probably stands for "digital camera images".  At least Canon
> digital cameras always put their data in a directory named dcim.

Yes. I know. Seems to be standard. The stick is for my Sony camera. 

However, the question is: how in **** is the Linux kernel seeing that
directory while it's not on the stick? (the root directory has one
MEMSTICK.IND file, and nothing else!)

				Roger.

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
