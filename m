Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264430AbUEXUDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264430AbUEXUDj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 16:03:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264585AbUEXUDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 16:03:39 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:3321 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264430AbUEXUDf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 16:03:35 -0400
Date: Mon, 24 May 2004 22:03:27 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 =?iso-8859-1?Q?patch=5D=A0mor?=
	=?iso-8859-1?Q?e?= InterMezzo removal
Message-ID: <20040524200326.GL16099@fs.tum.de>
References: <20040523234447.GE16099@fs.tum.de> <200405240135.i4O1ZLd01238@pincoya.inf.utfsm.cl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200405240135.i4O1ZLd01238@pincoya.inf.utfsm.cl>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 23, 2004 at 09:35:20PM -0400, Horst von Brand wrote:
> Adrian Bunk <bunk@fs.tum.de> said:
> > The patch below removes the MAINTAINERS entry for InterMezzo.
> 
> I'd leave it, with a note "Deleted for lack of maintenance" or such.

IMHO, MAINTAINERS should list the current maintainers of in-kernel code.

I wouldn't oppose if you'd like to document the fate of e.g. InterMezzo 
and xiafs somewhere, but I don't think a file that lists the current 
maintainers is the right place.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

