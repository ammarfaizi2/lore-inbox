Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290547AbSAYE5p>; Thu, 24 Jan 2002 23:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290557AbSAYE5f>; Thu, 24 Jan 2002 23:57:35 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:13321 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S290547AbSAYE5a>;
	Thu, 24 Jan 2002 23:57:30 -0500
Date: Fri, 25 Jan 2002 02:57:02 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: <rwhron@earthlink.net>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18pre4aa1
In-Reply-To: <20020124235608.C1096@earthlink.net>
Message-ID: <Pine.LNX.4.33L.0201250256170.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 24 Jan 2002 rwhron@earthlink.net wrote:

> > workloads, I'm not sure I want to make the system more
> > unfair just to better accomodate dbench ;)
>
> I'm wondering if rmap is a little too aggressive on
> read-ahead, and if that has a negative impact on
> a complex workload.

I haven't changed the readahead code one bit compared
to 2.4 mainline, but I'm wondering the same.

Fixing readahead window sizing has been on my TODO list
for quite a while already.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

