Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266548AbSKULHl>; Thu, 21 Nov 2002 06:07:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266552AbSKULHl>; Thu, 21 Nov 2002 06:07:41 -0500
Received: from emory.viawest.net ([216.87.64.6]:57294 "EHLO emory.viawest.net")
	by vger.kernel.org with ESMTP id <S266548AbSKULHk>;
	Thu, 21 Nov 2002 06:07:40 -0500
Date: Thu, 21 Nov 2002 03:14:39 -0800
From: A Guy Called Tyketto <tyketto@wizard.com>
To: Oliver Neukum <oliver@neukum.name>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19: deleting files on hfs causes oops
Message-ID: <20021121111439.GA18678@wizard.com>
References: <20021121093021.GA17678@wizard.com> <200211211207.05009.oliver@neukum.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200211211207.05009.oliver@neukum.name>
User-Agent: Mutt/1.4i
X-Operating-System: Linux/2.4.19 (i686)
X-uptime: 03:12:13 up 24 days, 14:45,  2 users,  load average: 0.22, 0.25, 0.16
X-RSA-KeyID: 0xE9DF4D85
X-DSA-KeyID: 0xE319F0BF
X-GPG-Keys: see http://www.wizard.com/~tyketto/pgp.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 21, 2002 at 12:07:04PM +0100, Oliver Neukum wrote:
> Am Donnerstag, 21. November 2002 10:30 schrieb A Guy Called Tyketto:
> >         Subject sez it all. Want more? you got it.
> 
> Thanks,
> 
> did you previously create the directory you deleted in?
> I am currently trying to pinpoint this bug, time permitting.
> 
> 	Regards
> 		Oliver
> 

        Directory was already created prior to mounting the fs in the ls-120 
drive. It was mounted rw, so removing a simple file shouldn't have been a 
problem. both directory and file pre-existed before the rm.

                                                        BL.
-- 
Brad Littlejohn                         | Email:        tyketto@wizard.com
Unix Systems Administrator,             |           tyketto@ozemail.com.au
Web + NewsMaster, BOFH.. Smeghead! :)   |   http://www.wizard.com/~tyketto
  PGP: 1024D/E319F0BF 6980 AAD6 7329 E9E6 D569  F620 C819 199A E319 F0BF

