Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272559AbRIPRBT>; Sun, 16 Sep 2001 13:01:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272549AbRIPRBL>; Sun, 16 Sep 2001 13:01:11 -0400
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:62989 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S272547AbRIPRA4>; Sun, 16 Sep 2001 13:00:56 -0400
Date: Sun, 16 Sep 2001 19:01:17 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Petr Vandrovec <vandrove@vc.cvut.cz>, linux-kernel@vger.kernel.org,
        VDA@port.imtp.ilyichevsk.odessa.ua
Subject: Re: Athlon: Try this (was: Re: Athlon bug stomping #2)
Message-ID: <20010916190117.A6307@suse.cz>
In-Reply-To: <20010916155045.A5671@suse.cz> <E15idD9-0005LA-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15idD9-0005LA-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Sun, Sep 16, 2001 at 03:47:55PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 16, 2001 at 03:47:55PM +0100, Alan Cox wrote:
> > > One way to test this hypthesis maybe to run dmidecode on the machines and
> > > see if they report KT133 or KT133A. Its also possible some BIOS code does
> > > blindly program bit 7 even tho its reserved and should have been kept
> > > unchanged.
> > 
> > I think it's possible to decide whether a chipset is KT133 or KT133A
> > based on the hostbridge revision. Mine is KT133 and is rev 03.
> 
> That tells you the chipset of the bridge. dmidecode dumps bios strings which
> may tell you the chipset the bios was actually for..

Ahh, yes.

-- 
Vojtech Pavlik
SuSE Labs
