Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266220AbRG2W3w>; Sun, 29 Jul 2001 18:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266263AbRG2W3m>; Sun, 29 Jul 2001 18:29:42 -0400
Received: from ns3.keyaccesstech.com ([209.47.245.85]:56591 "EHLO
	terbidium.openservices.net") by vger.kernel.org with ESMTP
	id <S266220AbRG2W3f>; Sun, 29 Jul 2001 18:29:35 -0400
Date: Sun, 29 Jul 2001 18:29:42 -0400 (EDT)
From: Ignacio Vazquez-Abrams <ignacio@openservices.net>
To: <linux-kernel@vger.kernel.org>
Subject: Re: DMA problem (?) w/ 2.4.6-xfs and ServerWorks OSB4 Chipset
In-Reply-To: <01072916503504.04012@bozo>
Message-ID: <Pine.LNX.4.33.0107291827520.8254-100000@terbidium.openservices.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-scanner: scanned by Inflex 1.0.7 - (http://pldaniels.com/inflex/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Sun, 29 Jul 2001, Marvin Justice wrote:

> On an unrelated topic the Serverworks LE chipset does not seem to be capable
> of handling 4GB of RAM, despite what the board vendors claim in their specs.
> When a 4th 1G stick is added the system gets really slow --- like maybe
> cacheing is disabled. We've seen this on both Tyan and SuperMicro boards. The
> HE chipset seems to be ok.
>
> Marvin Justice

I believe I remember a thread some time ago regarding the fact that
sometimes caching only works for a certain maximum amount of memory. It could
very well be that this is the case.

-- 
Ignacio Vazquez-Abrams  <ignacio@openservices.net>

