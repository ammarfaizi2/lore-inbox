Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319812AbSIMWil>; Fri, 13 Sep 2002 18:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319816AbSIMWil>; Fri, 13 Sep 2002 18:38:41 -0400
Received: from 2-028.ctame701-1.telepar.net.br ([200.193.160.28]:54938 "EHLO
	2-028.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S319812AbSIMWik>; Fri, 13 Sep 2002 18:38:40 -0400
Date: Fri, 13 Sep 2002 19:42:57 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Xavier Bestel <xavier.bestel@free.fr>
cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Good way to free as much memory as possible under 2.5.34?
In-Reply-To: <1031953717.20072.5.camel@bip>
Message-ID: <Pine.LNX.4.44L.0209131942330.1857-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Sep 2002, Xavier Bestel wrote:
> Le ven 13/09/2002 à 23:33, Rik van Riel a écrit :
>
> > I suspect only very few people will use swsuspend, so it should
> > not be intrusive.
>
> I don't think so.

You think many people will use it, or you think swsuspend
should be intrusive and have code in all other kernel
subsystems ? ;)

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/

Spamtraps of the month:  september@surriel.com trac@trac.org

