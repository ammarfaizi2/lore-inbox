Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSAVXuo>; Tue, 22 Jan 2002 18:50:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289577AbSAVXuh>; Tue, 22 Jan 2002 18:50:37 -0500
Received: from garrincha.netbank.com.br ([200.203.199.88]:23556 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S289564AbSAVXuU>;
	Tue, 22 Jan 2002 18:50:20 -0500
Date: Tue, 22 Jan 2002 21:49:58 -0200 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@imladris.surriel.com>
To: Steve Brueggeman <xioborg@yahoo.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Athlon PSE/AGP Bug
In-Reply-To: <c5qr4uk3adm53fgvuibld2tnjtnfnq0a5i@4ax.com>
Message-ID: <Pine.LNX.4.33L.0201222146090.32617-100000@imladris.surriel.com>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Jan 2002, Steve Brueggeman wrote:

> I AM NOT stating that this is necessarily the Athelon bug exposed by
> gentoo, but it appears that there are enough people complaining about
> unstable systems, becoming stable by running with the mem=nopentium.
> It also appears that a significant number of them are also running
> Nvidia AGP graphics adapters.

Daniel Robbins, William Lee Irwin and myself were on the
phone with people from AMD today.

One possible cause for this problem was already tracked
down a while ago; this problem isn't the fault of any
particular part of the system (CPU, OS, AGP or graphics
driver) but simply a consequence of how these things
work together. Of course we don't know if this particular
bug is the one hitting Linux systems with nvidia.

I won't post my poorly explained version of the story
here as the AMD guys are working on releasing their
well-written version of the story somewhere in the next
few days...

kind regards,

Rik
-- 
"Linux holds advantages over the single-vendor commercial OS"
    -- Microsoft's "Competing with Linux" document

http://www.surriel.com/		http://distro.conectiva.com/

