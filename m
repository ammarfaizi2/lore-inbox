Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291406AbSBXVnS>; Sun, 24 Feb 2002 16:43:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291397AbSBXVnM>; Sun, 24 Feb 2002 16:43:12 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:55044 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S291414AbSBXVmx>; Sun, 24 Feb 2002 16:42:53 -0500
Date: Sun, 24 Feb 2002 22:42:46 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Rik van Riel <riel@conectiva.com.br>
Cc: nick@snowman.net, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Martin Dalecki <dalecki@evision-ventures.com>,
        Troy Benjegerdes <hozer@drgw.net>,
        Linus Torvalds <torvalds@transmeta.com>,
        Andre Hedrick <andre@linuxdiskcert.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Flash Back -- kernel 2.1.111
Message-ID: <20020224224246.C1949@ucw.cz>
In-Reply-To: <Pine.LNX.4.21.0202241624330.10803-100000@ns> <Pine.LNX.4.33L.0202241831330.7820-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33L.0202241831330.7820-100000@imladris.surriel.com>; from riel@conectiva.com.br on Sun, Feb 24, 2002 at 06:32:09PM -0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 24, 2002 at 06:32:09PM -0300, Rik van Riel wrote:
> On Sun, 24 Feb 2002 nick@snowman.net wrote:
> 
> > None of the chipsets that supported VLB had more than one buss.  What
> > I don't know is some idiot may have built a VLB-VLB bridge, but I
> > doubt it.
> 
> There are PCI-VLB bridges.  Though it's unlikely, it may be
> possible that there are systems with multiple such bridges
> around... ;)

Uhh? I thought most the PCI & VLB systems had the PCI hanging off the
VLB and not the other way around. At least those I've seen had it this
way.

-- 
Vojtech Pavlik
SuSE Labs
