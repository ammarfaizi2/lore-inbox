Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313505AbSDUQHN>; Sun, 21 Apr 2002 12:07:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313508AbSDUQHM>; Sun, 21 Apr 2002 12:07:12 -0400
Received: from panic.tn.gatech.edu ([130.207.137.62]:28063 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S313505AbSDUQHL>;
	Sun, 21 Apr 2002 12:07:11 -0400
Date: Sun, 21 Apr 2002 12:07:10 -0400
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Urban Widmark <urban@teststation.com>
Cc: "Ivan G." <ivangurdiev@yahoo.com>, Shing Chuang <ShingChuang@via.com.tw>,
        LKML <linux-kernel@vger.kernel.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>
Subject: Re: [PATCH] Via-rhine minor issues
Message-ID: <20020421120710.H2301@havoc.gtf.org>
In-Reply-To: <02042101022001.00833@cobra.linux> <Pine.LNX.4.33.0204211151010.13036-100000@cola.teststation.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 12:19:40PM +0200, Urban Widmark wrote:
> On Sun, 21 Apr 2002, Ivan G. wrote:
> 
> > DIFF-ED AGAINST:
> > 2.4.19-pre3 ( I don't think there were changes to via-rhine 
> > b-ween pre3 and pre7)
> 
> You should probably send this to Jeff Garzik instead of Marcelo. Jeff
> collects net driver patches.
> 
> If you don't, Shing Chuang's changes are in -pre7-ac2, so a re-diff vs
> that and seding it to Alan Cox may cause less merge work.

Does Ivan's patch look ok to you, Urban?  I'd like to get your initial
sign-off on it.  From a quick look, it looks ok to me.

And yes, you are correct:  my preference would be to receive two
submissions in my inbox:  Shing Chuang's patch, and then Ivan's patch
(less Shing's work).

If there are multiple issues, multiple patches are encouraged.  More
split-up is always better than less.  :)

Regards,

	Jeff



