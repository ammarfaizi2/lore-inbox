Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312859AbSDOFa6>; Mon, 15 Apr 2002 01:30:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312888AbSDOFa5>; Mon, 15 Apr 2002 01:30:57 -0400
Received: from surf.viawest.net ([216.87.64.26]:16035 "EHLO surf.viawest.net")
	by vger.kernel.org with ESMTP id <S312859AbSDOFa4>;
	Mon, 15 Apr 2002 01:30:56 -0400
Date: Sun, 14 Apr 2002 22:30:52 -0700
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.8 croaks with USB and make dep
Message-ID: <20020415053052.GA29378@wizard.com>
In-Reply-To: <20020415024914.GA28512@wizard.com> <20020415042147.GA18791@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux/2.5.7 (i686)
X-uptime: 10:28pm  up 4 days,  3:45,  2 users,  load average: 0.00, 0.00, 0.00
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 14, 2002 at 09:21:47PM -0700, Greg KH wrote:
> On Sun, Apr 14, 2002 at 07:49:14PM -0700, A Guy Called Tyketto wrote:
> > 
> >         Subject sez it all:
> 
> Did you run 'make oldconfig' first?
> How about 'make mrproper'?  You might have to clean out some old files
> first, as the USB files all moved around.
> 
> thanks,
> 
> greg k-h

        Yep. make mrproper followed by make {x,old}config. same thing 
happens. Other thing I should mention, is that I have patched from 2.5.5 up to 
2.5.8. I'm not sure if the file exists in the full tarball or not. Will find 
out a bit later.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

