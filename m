Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277730AbRJRQG6>; Thu, 18 Oct 2001 12:06:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277783AbRJRQGi>; Thu, 18 Oct 2001 12:06:38 -0400
Received: from dvmwest.gt.owl.de ([62.52.24.140]:2832 "EHLO dvmwest.gt.owl.de")
	by vger.kernel.org with ESMTP id <S277730AbRJRQGf>;
	Thu, 18 Oct 2001 12:06:35 -0400
Date: Thu, 18 Oct 2001 18:07:06 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-kernel@vger.kernel.org
Subject: Re: MODULE_LICENSE and EXPORT_SYMBOL_GPL
Message-ID: <20011018180705.B13661@lug-owl.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3bcef893.4872.0@panix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3bcef893.4872.0@panix.com>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux mail 2.4.5 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2001-10-18 11:43:15 -0500, Roy Murphy <murphy@panix.com>
wrote in message <3bcef893.4872.0@panix.com>:
> 'Twas brillig when Arjan van de Ven scrobe:
> >I think you're missing one thing: binary only modules are only allowed
> >because of an exception license grant Linus made for functions that are
> >marked EXPORT_SYMBOL(). EXPORT_SYMBOL_GPL() just says "not part of 
> >this exception grant"....
> 
> of the Copyright to the kernel to grant or to restrict.  Does Microsoft have
> a legal right to disallow any third-party drivers from 
> registering themselves with the OS?  Does Linus?

They do, but they won't use it. They want to *sell* windows and they're
(more or less) willing to decode their blue screens produced by 3rd
vendor's drivers. However, GPL people may (or may not) be willing to
spend time in searching bugs in other company's drivers. However, *I* am
not willig to do other people's job, especially if *they* earn money
therefor... 

MfG, JBG

-- 
Jan-Benedict Glaw . jbglaw@lug-owl.de . +49-172-7608481
