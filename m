Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273467AbRIUMNP>; Fri, 21 Sep 2001 08:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273470AbRIUMNF>; Fri, 21 Sep 2001 08:13:05 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:11539 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S273467AbRIUMM5>;
	Fri, 21 Sep 2001 08:12:57 -0400
Date: Fri, 21 Sep 2001 09:13:07 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.rielhome.conectiva>
To: Stephan von Krawczynski <skraw@ithnet.com>
Cc: Bill Davidsen <davidsen@tmr.com>, <linux-kernel@vger.kernel.org>
Subject: Re: broken VM in 2.4.10-pre9
In-Reply-To: <20010921124338.4e31a635.skraw@ithnet.com>
Message-ID: <Pine.LNX.4.33L.0109210912310.19147-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Sep 2001, Stephan von Krawczynski wrote:

> Shit, if I only were able to implement that. Can anybody help me to
> proove my point?

Trying to implement your idea would probably pose a nice
counter-argument. Without measuring which pages are in
heavy use, how are you going to evict the right pages ?

regards,

Rik
-- 
IA64: a worthy successor to i860.

http://www.surriel.com/		http://distro.conectiva.com/

Send all your spam to aardvark@nl.linux.org (spam digging piggy)

