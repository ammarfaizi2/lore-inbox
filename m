Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262276AbREXU6U>; Thu, 24 May 2001 16:58:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262277AbREXU6L>; Thu, 24 May 2001 16:58:11 -0400
Received: from idiom.com ([216.240.32.1]:28434 "EHLO idiom.com")
	by vger.kernel.org with ESMTP id <S262276AbREXU6A>;
	Thu, 24 May 2001 16:58:00 -0400
Message-ID: <3B0D7522.351CD4B5@namesys.com>
Date: Thu, 24 May 2001 13:54:58 -0700
From: Hans Reiser <reiser@namesys.com>
Organization: Namesys
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, ru
MIME-Version: 1.0
To: J Sloan <jjs@toyota.com>
CC: Andi Kleen <ak@suse.de>, Andreas Dilger <adilger@turbolinux.com>,
        monkeyiq <monkeyiq@users.sourceforge.net>,
        linux-kernel@vger.kernel.org, Nikita Danilov <god@namesys.com>
Subject: Re: Dying disk and filesystem choice.
In-Reply-To: <m3bsoj2zsw.fsf@kloof.cr.au> <200105240658.f4O6wEWq031945@webber.adilger.int> <20010524103145.A9521@gruyere.muc.suse.de> <3B0D3C99.255B5A24@namesys.com> <3B0D5AEB.9A72E01A@lexus.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J Sloan wrote:
> 
> Excellent!
> 
> Will this be in resierfs 4.0 then?
> 
> cu
> 
> jjs
> 
> Hans Reiser schrieb:
> 
> > No, reiserfs does have badblock support!!!!
> >
> > You just have to get it as a separate patch from us because it was written after
> > code freeze.


No, version 4 won't ship until september 2002, these features are all v3.7,
which will be sent to Linus as soon as 2.5.1 opens up.

Hans
