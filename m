Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312825AbSDDAUP>; Wed, 3 Apr 2002 19:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312846AbSDDAUG>; Wed, 3 Apr 2002 19:20:06 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6408 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S312825AbSDDAT5>;
	Wed, 3 Apr 2002 19:19:57 -0500
Date: Wed, 3 Apr 2002 21:19:30 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Petr Vandrovec <VANDROVE@vc.cvut.cz>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
        Gerd Knorr <kraxel@bytesex.org>, <linux-kernel@vger.kernel.org>,
        Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 2.5.5] do export vmalloc_to_page to modules...
In-Reply-To: <159BD1442BE@vcnet.vc.cvut.cz>
Message-ID: <Pine.LNX.4.44L.0204032029110.18660-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Apr 2002, Petr Vandrovec wrote:
> On  3 Apr 02 at 19:39, Rik van Riel wrote:

> > Indeed, Veritas has contributed significantly to kernel development,
> > but I can't remember ever seeing anything but troubled users from
> > companies like nvidia or vmware.
> >
> > Veritas was a bad example indeed ;)
>
> Well, now I feel really offended. Maybe my contributions are not so big
> as yours, but I think that negating them completely is way too off.
>                                                 Petr Vandrovec
>                                          (also) petr@vmware.com

I guess Davem's comments apply, I see lots of VANDROVE@vc.cvut.cz
in my email archive but this is the first petr@vmware.com that I
see:

$ grep -i Vandrov ~/mail/linux-kernel-Wk* | wc -l
343
$ grep -i petr@vmware ~/mail/linux-kernel-Wk* | wc -l
1


regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".

http://www.surriel.com/		http://distro.conectiva.com/


