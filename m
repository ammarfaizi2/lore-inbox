Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316664AbSGBHKV>; Tue, 2 Jul 2002 03:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316663AbSGBHKV>; Tue, 2 Jul 2002 03:10:21 -0400
Received: from postfix1-2.free.fr ([213.228.0.130]:55979 "EHLO
	postfix1-2.free.fr") by vger.kernel.org with ESMTP
	id <S316664AbSGBHKT>; Tue, 2 Jul 2002 03:10:19 -0400
Message-Id: <200207020627.g626RRO29859@colombe.home.perso>
Date: Tue, 2 Jul 2002 08:27:24 +0200 (CEST)
From: fchabaud@free.fr
Reply-To: fchabaud@free.fr
Subject: Re: [PATCH][swsusp] 2.4.19-pre10-ac2
To: swsusp@lister.fornax.hu
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20020630214935.GA103@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Le 30 Jui, Pavel Machek a écrit :
> Hi!
> 
>> Following six patches for swsusp that were used by various people
>> through swsusp list. They should apply in order to 2.4.19-pre10-ac2.
>> Most of those is already in 2.5.22 suspend part managed by Pavel.
> 
> Heh, so now I'm going patch by patch to figure what to merge :-(.

Actually, that was intended for Alan to have one patch for one function
(well at least that was the idea ;-)


> 
>> 1/6	Documentation and comments cleanings
> 
> @@ -1715,9 +1715,9 @@
>  S: Germany
> 
>  N: Gabor Kuti
> -E: seasons@falcon.sch.bme.hu
> -E: seasons@makosteszta.sote.hu
> -D: Author and Maintainer for Software Suspend
> +M: seasons@falcon.sch.bme.hu
> +M: seasons@makosteszta.sote.hu
> +D: Software suspend
> 
>  N: Jaroslav Kysela
>  E: perex@suse.cz
> 
> Why do you change E to M here?

That's a mistake. The fact was that Gabor was inserted twice.

--
Florent

