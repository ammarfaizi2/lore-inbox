Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261497AbSJZTmf>; Sat, 26 Oct 2002 15:42:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261510AbSJZTmf>; Sat, 26 Oct 2002 15:42:35 -0400
Received: from 3-090.ctame701-1.telepar.net.br ([200.193.161.90]:52611 "EHLO
	3-090.ctame701-1.telepar.net.br") by vger.kernel.org with ESMTP
	id <S261497AbSJZTme>; Sat, 26 Oct 2002 15:42:34 -0400
Date: Sat, 26 Oct 2002 17:48:11 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: "J.A. Magallon" <jamagallon@able.es>
cc: "Nakajima, Jun" <jun.nakajima@intel.com>, Robert Love <rml@tech9.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "'Dave Jones'" <davej@codemonkey.org.uk>,
       "'akpm@digeo.com'" <akpm@digeo.com>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'chrisl@vmware.com'" <chrisl@vmware.com>,
       "'Martin J. Bligh'" <mbligh@aracnet.com>
Subject: Re: [PATCH] hyper-threading information in /proc/cpuinfo
In-Reply-To: <20021026004320.GA1676@werewolf.able.es>
Message-ID: <Pine.LNX.4.44L.0210261746520.1697-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 26 Oct 2002, J.A. Magallon wrote:

> Summary:

> - each package can handle several (someone said 128+ ;) ) processor cores.
>   We really do not mind if they are really independent (power4) or not
>   (xeon, ht)

Here is the big opinion of difference.  Apparently people _do_
care, otherwise they would have never asked for HT evil twins
to be reported separately in /proc.

kind regards,

Rik
-- 
Bravely reimplemented by the knights who say "NIH".
http://www.surriel.com/		http://distro.conectiva.com/
Current spamtrap:  <a href=mailto:"october@surriel.com">october@surriel.com</a>

