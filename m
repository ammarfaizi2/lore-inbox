Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132512AbRDUUvU>; Sat, 21 Apr 2001 16:51:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132503AbRDUUvK>; Sat, 21 Apr 2001 16:51:10 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:49413 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132512AbRDUUux>;
	Sat, 21 Apr 2001 16:50:53 -0400
Date: Sat, 21 Apr 2001 17:45:18 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Doug McNaught <doug@wireboard.com>, Miles Lane <miles@megapathdsl.net>,
        linux-kernel@vger.kernel.org, linux-openlvm@nl.linux.org,
        linux-lvm@sistina.com
Subject: Re: [repost] Announce: Linux-OpenLVM mailing list
In-Reply-To: <20010421015555.L805@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.21.0104211743440.1685-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Apr 2001, Matti Aarnio wrote:

>   If you are PERL speaker (or can at least comprehend perl's
>   m(atch) expressions), here is URL to info about it, plus
>   the actual live running filter-set:
> 
>     http://vger.kernel.org/majordomo-info.html
> 
>   Go to the end of the page, and you see link for the actual
>   filter code used at the VGER's Majordomo.

To get the filter set used by NL.linux.org:

cvs -d :pserver:cvs@nl.linux.org:/home/CVS login
password: cvs
cvs -d :pserver:cvs@nl.linux.org:/home/CVS checkout spamfilter

You can also use the regexps and the script in this CVS tree to
build your own majordomo.cf automatically whenever new regexps
get added.

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

