Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280233AbRKBObc>; Fri, 2 Nov 2001 09:31:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280273AbRKBObX>; Fri, 2 Nov 2001 09:31:23 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:27928 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S280233AbRKBObR>; Fri, 2 Nov 2001 09:31:17 -0500
Date: Fri, 2 Nov 2001 15:31:15 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Samium Gromoff <_deepfire@mail.ru>
Cc: linux-kernel@vger.kernel.org, riel@surriel.com
Subject: Re: OOM /proc logging
Message-ID: <20011102153115.F1313@athlon.random>
In-Reply-To: <200111020902.fA292A818161@vegae.deep.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <200111020902.fA292A818161@vegae.deep.net>; from _deepfire@mail.ru on Fri, Nov 02, 2001 at 12:02:06PM +0300
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 02, 2001 at 12:02:06PM +0300, Samium Gromoff wrote:
>         Hello folks...
>      After another complain on #kernelnewbies about the OOM killer doing
>   strange thingss, by killing small processes when its really not needed,

I think it's not reproducible on 2.4.14pre6aa1.

>   and not doing anything when its really OOM i ran out of nerves and came out
>   with an idea, which i believe already settled down is some brains.
>     I speak about providing in /proc list of process badnesses, possibly with
>   some additional info...
>     Its just a shame to have a stable kernel randomly killing processes even when 
>   its not needed...
> 
>   (this message was planned as answer to Linus request for any kind of VM bitchig....)
> 
> regards, Samium Gromoff


Andrea
