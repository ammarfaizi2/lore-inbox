Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313123AbSDDKEf>; Thu, 4 Apr 2002 05:04:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313124AbSDDKEZ>; Thu, 4 Apr 2002 05:04:25 -0500
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:48133
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S313123AbSDDKEU>; Thu, 4 Apr 2002 05:04:20 -0500
Date: Thu, 4 Apr 2002 02:03:31 -0800 (PST)
From: Andre Hedrick <andre@linux-ide.org>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
cc: "jim@rubylane.com" <jim@rubylane.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Re[2]: Update on Promise 100TX2 + Serverworks IDE issues --
 2.2.20
In-Reply-To: <ISPFE11vdnznMEmPzhz00000d07@mail.takas.lt>
Message-ID: <Pine.LNX.4.10.10204040202220.7246-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I need to find time to publish and break down a new 352K patch for
2.4.19-pre4 that covers this issue also.

Andre Hedrick
LAD Storage Consulting Group

On Thu, 4 Apr 2002, Nerijus Baliunas wrote:

> On Tue, 2 Apr 2002 18:58:20 -0800 (PST) "jim@rubylane.com" <jim@rubylane.com> wrote:
> 
> j> This board does claim to support UDMA33 and Linux says the MB IDE
> j> ports are in UDMA33 mode.  Works fine in just PIO mode.  Slower, but
> j> at least it doesn't trash drives.
> 
> j> This board says:
> j> 
> j> ServerWorks OSB4: IDE controller on PCI bus 00 dev 79
> j> ServerWorks OSB4: chipset revision 0
> 
> IIRC downgrading DMA to MDMA2 should help.
> 
> Regards,
> Nerijus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

