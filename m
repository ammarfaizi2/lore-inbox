Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288691AbSADRTx>; Fri, 4 Jan 2002 12:19:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280126AbSADRTd>; Fri, 4 Jan 2002 12:19:33 -0500
Received: from dark.pcgames.pl ([195.205.62.2]:13702 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S279798AbSADRTZ>;
	Fri, 4 Jan 2002 12:19:25 -0500
Date: Fri, 4 Jan 2002 18:18:49 +0100 (CET)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: Mark Hahn <hahn@physics.mcmaster.ca>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Two hdds on one channel - why so slow?
In-Reply-To: <Pine.LNX.4.33.0201040844130.14385-100000@coffee.psychology.mcmaster.ca>
Message-ID: <Pine.LNX.4.33.0201041803310.294-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 4 Jan 2002, Mark Hahn wrote:

> > Yes. IDE as a PtP device works nice. But this means that in most cases
> > it is possible to connect only half of expected devices. What a pity :(
> "expected".  if you require 2disks/chain, then sure, ide will be
> a disappointment.  since an ide chain costs O($15), you're crying
> about spilled beer...

Actually it costs much more. For example Promise Ultra100TX2
costs about 54$ (so is is 27$ per channel). Ultra133TX2 is more expensive
- around 88$. It is more than half of TEKRAM DC-390U2W (Ultra2+Ultra
SCSI Adapter) with Symbios 53C895 chipset. Those are SRP prices with VAT
tax. Maybe prices in USA/Canada are much lower...


Best regards,

			Krzysztof Oledzki

