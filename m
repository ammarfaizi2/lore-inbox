Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314602AbSGXI7z>; Wed, 24 Jul 2002 04:59:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315293AbSGXI7z>; Wed, 24 Jul 2002 04:59:55 -0400
Received: from moutvdom.kundenserver.de ([195.20.224.200]:467 "EHLO
	moutvdomng3.kundenserver.de") by vger.kernel.org with ESMTP
	id <S314602AbSGXI7y>; Wed, 24 Jul 2002 04:59:54 -0400
Date: Wed, 24 Jul 2002 03:03:02 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Nico Schottelius <nicos-mutt@pcsystems.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Richard E. Gooch" <rgooch@atnf.csiro.au>
Subject: Re: [BUG] 2.5.27 devfs /dev/vc failure
In-Reply-To: <20020724103927.GA487@schottelius.org>
Message-ID: <Pine.LNX.4.44.0207240302330.3366-100000@hawkeye.luckynet.adm>
X-Location: Dorndorf; Germany
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 24 Jul 2002, Nico Schottelius wrote:
> I was wondering why 2.5.27 all gettys are not started, but after logging
> in via network a ls /dev/vc returned
> 
>    /dev/vc/0
> 
> and nothing more!   

It's not your problem, but a but in the sources :-). See:
http://marc.theaimsgroup.com/?l=linux-kernel&m=102735450602247&w=2

(quoting Jose Luis Domingo Lopez)

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

