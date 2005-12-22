Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965144AbVLVJOL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965144AbVLVJOL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Dec 2005 04:14:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965145AbVLVJOL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Dec 2005 04:14:11 -0500
Received: from cid.upco.es ([130.206.70.227]:19155 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S965144AbVLVJOJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Dec 2005 04:14:09 -0500
Date: Thu, 22 Dec 2005 10:14:28 +0100
From: Romano Giannetti <romanol@upcomillas.es>
To: Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: About 4k kernel stack size....
Message-ID: <20051222091428.GB1876@pern.dea.icai.upcomillas.es>
Mail-Followup-To: Romano Giannetti <romanol@upcomillas.es>,
	Giridhar Pemmasani <giri@lmc.cs.sunysb.edu>,
	linux-kernel@vger.kernel.org
References: <20051218231401.6ded8de2@werewolf.auna.net> <43A77205.2040306@rtr.ca> <20051220133729.GC6789@stusta.de> <170fa0d20512200637l169654c9vbe38c9931c23dfb1@mail.gmail.com> <BAYC1-PASMTP01F075F44E45AA32F0DF85AE3E0@CEZ.ICE> <dobr1u$19t$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <dobr1u$19t$1@sea.gmane.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 21, 2005 at 10:07:01AM -0500, Giridhar Pemmasani wrote:
> Sean wrote:
> 
> > I for one hope those silly bastards using ndiswrapper fix up that code to
>                        ^^^^^^^^^^^^^^
> It is despicable that some of the proponents of this 4k-only stack size have
> resorted to such epithets. 

Yes, a bit sad it is. 

Being one of those silly bastard that have to use ndiswrapper to connect to
my Uni wifi, I want to pubblically thanks Giri for his work. I'd love a
world where wifi cards will have native linux open source drivers, but _now_
my only other option is to boot in windows --- which I do not even have on my
laptop. 

Nevertheless, I think that if the bulk of kernel developers feel the need to
go to 4k kernel stack, they probably have *technical* reasons to do it
(which I, for my limited understanding, cannot discuss). That mean that
ndiswrapper will need to have a kernel patch; that's not a problem for me
nor for the majority of people in this list. 

For the other people, let distribution maintainer decide. I see ndiswrapper
nicely integrated in a lot of distro now, and I really do not see Mandriva
or whatever drop almost all the "wifi compatible" hardware list. Maybe they
will be pushed to develop open source driver (I hope). Maybe they simply
will ship patched kernel. Let's see. 

     Romano 


-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
http://www.dea.icai.upcomillas.es/romano/
