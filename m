Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288206AbSACEcm>; Wed, 2 Jan 2002 23:32:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288201AbSACEcW>; Wed, 2 Jan 2002 23:32:22 -0500
Received: from rwcrmhc52.attbi.com ([216.148.227.88]:38579 "EHLO
	rwcrmhc52.attbi.com") by vger.kernel.org with ESMTP
	id <S288158AbSACEcN>; Wed, 2 Jan 2002 23:32:13 -0500
Message-ID: <3C33DDB8.66918D99@didntduck.org>
Date: Wed, 02 Jan 2002 23:27:36 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.5.1-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: esr@thyrsus.com
CC: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
In-Reply-To: <20020102220333.A26713@thyrsus.com> <Pine.LNX.4.33.0201030420160.6449-100000@Appserv.suse.de> <20020102221845.A27252@thyrsus.com> <3C33D1B0.4DFDF76E@didntduck.org> <20020102223523.A27644@thyrsus.com> <3C33DAC8.E6872F16@didntduck.org> <20020102231541.A30988@thyrsus.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric S. Raymond" wrote:
> 
> Brian Gerst <bgerst@didntduck.org>:
> > > Nobody has told me this is a real failure case yet.  To cause a problem,
> > > the situation would have to be that DMI read fails to detect a card in
> > > use in an ISA slot.  It's OK if it reports no slots when all slots are
> > > empty.
> >
> > Well, I just popped in an old 3com 509TP network card (non-PnP) into my
> > main box and dmidecode still failed to show the single ISA slot, only 4
> > PCI and 1 AGP.
> 
> I realize this may sound like a dumb question...but are sure the card works
> and is not just an inert mass o' silicon?  I have couple of 3c509s knocking
> around here myself and I'm not at all sure they're alive.

Yes, it worked.

-- 

						Brian Gerst
