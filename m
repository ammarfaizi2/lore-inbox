Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293017AbSCDXso>; Mon, 4 Mar 2002 18:48:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293014AbSCDXsb>; Mon, 4 Mar 2002 18:48:31 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:6672 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S292764AbSCDXsW>;
	Mon, 4 Mar 2002 18:48:22 -0500
Date: Mon, 4 Mar 2002 20:48:02 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@imladris.surriel.com
To: Robert Love <rml@tech9.net>
Cc: Dieter =?ISO-8859-1?Q?N=FCtzel?= <Dieter.Nuetzel@hamburg.de>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@elte.hu>, Andrea Arcangeli <andrea@suse.de>
Subject: Re: latency & real-time-ness.
In-Reply-To: <1015266757.15277.4.camel@phantasy>
Message-ID: <Pine.LNX.4.44L.0203042047010.2181-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 Mar 2002, Robert Love wrote:

> If rmap finds its way into 2.5, I and others have some ideas about ways
> to optimize the algorithms to reduce lock hold time and benefit from
> preemption.  For example, Daniel Phillips has some ideas wrt
> zap_page_range.

Feel free to help resolve these issues before rmap code gets
merged. I'd prefer to be able to introduce rmap in small bits
and pieces without breaking anything.

regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

