Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278423AbRJMVxe>; Sat, 13 Oct 2001 17:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278426AbRJMVxY>; Sat, 13 Oct 2001 17:53:24 -0400
Received: from firebird.planetinternet.be ([195.95.34.5]:54533 "EHLO
	firebird.planetinternet.be") by vger.kernel.org with ESMTP
	id <S278423AbRJMVxF>; Sat, 13 Oct 2001 17:53:05 -0400
Date: Sat, 13 Oct 2001 23:55:22 +0200
From: Leopold Gouverneur <lgouv@planetinternet.be>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Problem with store fence fixes
Message-ID: <20011013235522.A4739@loclhost>
In-Reply-To: <20011013222518.A1559@loclhost> <E15sWiP-0003v9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15sWiP-0003v9-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 13, 2001 at 10:53:05PM +0100, Alan Cox wrote:
> > 	Unexpected IRQ trap at vector 75
> > 	Calibrating delay loop ..
> > Only the reset button helps. 2.4.10-ac8 works perfectly, ac9 also
> > if I suppress the line "define_bool CONFIG_X86_PPRO_FENCE y".
> > Since nobody is complaining, I suppose i am doing something wrong.
> > My system: Abit BP6, 2 Celeron 433( not OC )
> 
> I would guess you are using gcc 3.0.*
> 
> Alan
yes :(

