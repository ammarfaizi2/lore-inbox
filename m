Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129051AbRCWEMd>; Thu, 22 Mar 2001 23:12:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129509AbRCWEMW>; Thu, 22 Mar 2001 23:12:22 -0500
Received: from nrcvicex1a.hia.nrc.ca ([204.174.103.8]:53002 "EHLO
	nrcvicex1.hia.nrc.ca") by vger.kernel.org with ESMTP
	id <S129051AbRCWEMQ>; Thu, 22 Mar 2001 23:12:16 -0500
Message-ID: <3ABACD48.34848C56@nrc.ca>
Date: Thu, 22 Mar 2001 20:12:56 -0800
X-Sybari-Trust: 7c7fecdc 050014e6 00000000
From: Tony Hoffmann <tony.hoffmann@nrc.ca>
Organization: National Research Council of Canada
X-Mailer: Mozilla 4.76 [en] (Win98; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.2-ac21
In-Reply-To: <20010322162802.A909@the-penguin.otak.com> <3ABAA2E6.9D40B7B6@asiapacificm01.nt.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I also had my 3c905 behave this way with ac21.  ac20 is ok.  System uses an ABit kt7a board.

Andrew Morton wrote:

> Lawrence Walton wrote:
> >
> > Hello all
> > 2.4.2-ac21 seems to have a couple problems.
> > ...
> >
> > Mar 22 15:15:55 the-penguin kernel: NETDEV WATCHDOG: eth0: transmit timed out
> > ...
> > 00:01.0 PCI bridge: VIA Technologies, Inc. VT8363/8365 [KT133/KM133 AGP] (prog-if 00 [Normal decode])
>
> People have recently been changing VIA PCI bridge settings
> to try to fix the file corruption thing.  There has been one
> report that this change causes a 3c905C to go silly.
>
> This looks like the same problem to me.
>
> Arjan?
>
> -
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

