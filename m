Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292690AbSCBLGM>; Sat, 2 Mar 2002 06:06:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293652AbSCBLGC>; Sat, 2 Mar 2002 06:06:02 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:34058 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292690AbSCBLFx>;
	Sat, 2 Mar 2002 06:05:53 -0500
Date: Fri, 1 Mar 2002 18:13:49 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Bongani Hlope <bonganilinux@mweb.co.za>
Cc: linux-kernel@vger.kernel.org, Dan Chen <crimsun@email.unc.edu>
Subject: Re: [RFC][PATCH] #define yield() for 2.4 scheduler (anticipating
 O(1))
In-Reply-To: <1015017496.2325.7.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44L.0203011812370.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 Mar 2002, Bongani Hlope wrote:

> I think Ingo is using sys_sched_yield(); instead of yield. I will still
> be carefull about it though.

Hmm, I guess it is kind of important to use the same name
for yielding the CPU that ingo is using ;)

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/


