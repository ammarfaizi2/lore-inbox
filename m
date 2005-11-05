Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932078AbVKEP21@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078AbVKEP21 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 10:28:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932081AbVKEP21
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 10:28:27 -0500
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:4873 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S932078AbVKEP20 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 10:28:26 -0500
Date: Sat, 5 Nov 2005 16:28:22 +0100
From: Adrian Bunk <bunk@stusta.de>
To: Oliver Neukum <oliver@neukum.org>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Edgar Hucek <hostmaster@ed-soft.at>,
       Jean Delvare <khali@linux-fr.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: New Linux Development Model
Message-ID: <20051105152821.GH5368@stusta.de>
References: <436C7E77.3080601@ed-soft.at> <436CB162.5070100@ed-soft.at> <9a8748490511050634g8d19652w8148a3db4e3e11b2@mail.gmail.com> <200511051548.12562.oliver@neukum.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200511051548.12562.oliver@neukum.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 05, 2005 at 03:48:12PM +0100, Oliver Neukum wrote:
> Am Samstag, 5. November 2005 15:34 schrieb Jesper Juhl:
> > There is a very simple solution to your problem. Use the kernels
> > provided by your distribution and not the kernel.org kernels.
> 
> If enough people do so, testing will suffer.

For a _user_, it is the best choice to use the kernel provided by the 
distribution.

There _are_ incompatible changes between 2.6 kernels, and if you e.g. 
try to run kernel 2.6.14 on a Debian stable that ships only 2.6.8 you 
can always run into problems here or there.

And it seems we already have many big guinea pigs running the 
development branch of Fedora.

> 	Regards
> 		Oliver

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

