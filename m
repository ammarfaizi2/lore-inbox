Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280296AbRJaQvV>; Wed, 31 Oct 2001 11:51:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280297AbRJaQvL>; Wed, 31 Oct 2001 11:51:11 -0500
Received: from ns.censoft.com ([208.219.23.2]:65035 "EHLO ns.censoft.com")
	by vger.kernel.org with ESMTP id <S280296AbRJaQu5>;
	Wed, 31 Oct 2001 11:50:57 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jordan Crouse <jordanc@censoft.com>
Reply-To: jordanc@censoft.com
Organization: The Microwindows Project
To: Roy Sigurd Karlsbakk <roy@karlsbakk.net>, <linux-kernel@vger.kernel.org>
Subject: Re: which cpu?
Date: Wed, 31 Oct 2001 09:45:56 -0700
X-Mailer: KMail [version 1.3.1]
In-Reply-To: <Pine.LNX.4.30.0110311735170.27680-100000@mustard.heime.net>
In-Reply-To: <Pine.LNX.4.30.0110311735170.27680-100000@mustard.heime.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E15yyZw-000253-00@ns.censoft.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That chip is commonly called a Geode.... :)

I have found the best results by compiling for a straight 586....  That way 
you get all the benefits of the core 586 functionality, without straying into 
any possible problems with Intel/AMD extensions (MMX, etc...).

On Wednesday 31 October 2001 09:38, Roy Sigurd Karlsbakk mentioned:
> hi
>
> which cpu should I compile for, when having a so-called "National SC1200
> 32bit, 266MHz, x86-compatible processor with integrated TV video
> processor"?
>
> thanks
>
> please cc: to me as I'm not on the list
>
> roy
>
> ---
> Praktiserende dyslektiker.
> La ikke ortografiske krumspring skygge for
> intensjonen bak denne fremstilling.
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

