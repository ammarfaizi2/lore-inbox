Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317160AbSEXOya>; Fri, 24 May 2002 10:54:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317161AbSEXOy3>; Fri, 24 May 2002 10:54:29 -0400
Received: from twilight.ucw.cz ([195.39.74.230]:61106 "EHLO twilight.ucw.cz")
	by vger.kernel.org with ESMTP id <S317160AbSEXOy0>;
	Fri, 24 May 2002 10:54:26 -0400
Date: Fri, 24 May 2002 16:54:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Vojtech Pavlik <vojtech@suse.cz>, Oleg Drokin <green@namesys.com>,
        "Gryaznova E." <grev@namesys.botik.ru>, martin@dalecki.de,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Reiserfs developers mail-list <Reiserfs-Dev@namesys.com>
Subject: Re: [reiserfs-dev] Re: IDE problem: linux-2.5.17
Message-ID: <20020524165417.C10656@ucw.cz>
In-Reply-To: <3CECF59B.D471F505@namesys.botik.ru> <3CECFC5B.3030701@evision-ventures.com> <20020523193959.A2613@namesys.com> <3CED004A.6000109@evision-ventures.com> <20020524005057.F27005@ucw.cz> <3CEE1DFE.4080500@evision-ventures.com> <20020524151536.C636@ucw.cz> <3CEE2EE2.1040407@evision-ventures.com> <20020524152054.F636@ucw.cz> <3CEE42D0.8090004@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 24, 2002 at 03:40:32PM +0200, Martin Dalecki wrote:
> U¿ytkownik Vojtech Pavlik napisa³:
> 
> >>Hey what I'm talking about is the "physics" of the hardware.
> >>But I would rather expect sane hardware to deal with it transparently
> >>to the programmer of the setup registers.
> > 
> > 
> > Well, when I hear "timer" I think "engineering", not "physics". And a
> > timer would have to be visible somewhere. I really don't think the
> > controller can tell how many drives it sees unless it measures the
> > termination resistance or somesuch.
> 
> Jak siê zwa³ tak siê zwa³, byle by siê dobrze mia³ :-).
> 
> Anyway measuring the termination resistance is rather trivial
> from the electrical point of view...

Yes, but trust me that if they don't absolutely have to do it to make it
work, they won't do it. IDE hardware is cheap in the first place.

-- 
Vojtech Pavlik
SuSE Labs
