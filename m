Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135937AbRD0LOO>; Fri, 27 Apr 2001 07:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135915AbRD0LOD>; Fri, 27 Apr 2001 07:14:03 -0400
Received: from 4dyn180.delft.casema.net ([195.96.105.180]:60932 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S135937AbRD0LNp>; Fri, 27 Apr 2001 07:13:45 -0400
Message-Id: <200104271113.NAA16761@cave.bitwizard.nl>
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <988368729.1406.2.camel@nomade> from Xavier Bestel at "Apr 27, 2001
 12:51:34 pm"
To: Xavier Bestel <xavier.bestel@free.fr>
Date: Fri, 27 Apr 2001 13:13:39 +0200 (MEST)
CC: Goswin Brederlow <goswin.brederlow@student.uni-tuebingen.de>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        William T Wilson <fluffy@snurgle.org>, Matt_Domsch@Dell.com,
        linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Xavier Bestel wrote:
[Charset ISO-8859-1 unsupported, filtering to ASCII...]
> Le 08 Mar 2001 14:05:25 +0100, Goswin Brederlow a _crit :
> 
> > I believe the 2xRAM rule comes from the OS's where ram was only buffer
> > for the swap. So with 1xRAM you had a running system with 1xRAM
> > memory, so nothing is gained by that much swap.
> 
> I think kernels 2.4.x came back to this behavior.
>  
> > On Linux any swap adds to the memory pool, so 1xRAM would be
> > equivalent to 2xRAM with the old old OS's.
> 
> no more true AFAIK

I've always been trying to convice people that 2x RAM remains a good 
rule-of-thumb.

		Rogier. 



-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
