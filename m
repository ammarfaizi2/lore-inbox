Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S143402AbREKVPm>; Fri, 11 May 2001 17:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S143403AbREKVPd>; Fri, 11 May 2001 17:15:33 -0400
Received: from ns1.SuSE.com ([202.58.118.2]:54546 "HELO ns1.suse.com")
	by vger.kernel.org with SMTP id <S143402AbREKVPX>;
	Fri, 11 May 2001 17:15:23 -0400
Date: Fri, 11 May 2001 14:15:21 -0700
From: Mads Martin =?iso-8859-1?Q?J=F8rgensen?= <mmj@suse.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.4-ac8 now with added correct EXTRAVERSION
Message-ID: <20010511141521.A632@suse.com>
In-Reply-To: <E14yJEw-0001dW-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E14yJEw-0001dW-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Fri, May 11, 2001 at 09:10:17PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [May 11. 2001 13:18]:
> 2.4.4-ac8
> o	Tulip driver updates				(Jeff Garzik)

Networking stopped working with this kernel. I have the following
NIC:

02:0b.0 Ethernet controller: Lite-On Communications Inc LNE100TX (rev
20)
        Subsystem: Netgear FA310TX
        Control: I/O+ Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66Mhz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 32
        Interrupt: pin A routed to IRQ 3
        Region 0: I/O ports at b800 [size=256]
        Region 1: Memory at df800000 (32-bit, non-prefetchable)
[size=256]
        Expansion ROM at <unassigned> [disabled] [size=256K]

-- 
Mads Martin Joergensen, http://mmj.dk
"Why make things difficult, when it is possible to make them cryptic and
totally illogic, with just a little bit more effort."
                                -- A. P. J.
