Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288203AbSACEom>; Wed, 2 Jan 2002 23:44:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288207AbSACEoc>; Wed, 2 Jan 2002 23:44:32 -0500
Received: from dsl254-112-233.nyc1.dsl.speakeasy.net ([216.254.112.233]:34181
	"EHLO snark.thyrsus.com") by vger.kernel.org with ESMTP
	id <S288203AbSACEo1>; Wed, 2 Jan 2002 23:44:27 -0500
Date: Wed, 2 Jan 2002 23:30:46 -0500
From: "Eric S. Raymond" <esr@thyrsus.com>
To: Brian Gerst <bgerst@didntduck.org>
Cc: Dave Jones <davej@suse.de>, Lionel Bouton <Lionel.Bouton@free.fr>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA slot detection on PCI systems?
Message-ID: <20020102233046.A31522@thyrsus.com>
Reply-To: esr@thyrsus.com
Mail-Followup-To: "Eric S. Raymond" <esr@thyrsus.com>,
	Brian Gerst <bgerst@didntduck.org>, Dave Jones <davej@suse.de>,
	Lionel Bouton <Lionel.Bouton@free.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Linux Kernel List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020102220333.A26713@thyrsus.com> <Pine.LNX.4.33.0201030420160.6449-100000@Appserv.suse.de> <20020102221845.A27252@thyrsus.com> <3C33D1B0.4DFDF76E@didntduck.org> <20020102223523.A27644@thyrsus.com> <3C33DAC8.E6872F16@didntduck.org> <20020102231541.A30988@thyrsus.com> <3C33DDB8.66918D99@didntduck.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C33DDB8.66918D99@didntduck.org>; from bgerst@didntduck.org on Wed, Jan 02, 2002 at 11:27:36PM -0500
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brian Gerst <bgerst@didntduck.org>:
> > I realize this may sound like a dumb question...but are sure the card works
> > and is not just an inert mass o' silicon?  I have couple of 3c509s knocking
> > around here myself and I'm not at all sure they're alive.
> 
> Yes, it worked.

So there *is* a significant risk of false negatives.

Damn.  That is not good.
-- 
		<a href="http://www.tuxedo.org/~esr/">Eric S. Raymond</a>

"Among the many misdeeds of British rule in India, history will look
upon the Act depriving a whole nation of arms as the blackest."
        -- Mohandas Gandhi, An Autobiography, pg 446
