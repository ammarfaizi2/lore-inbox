Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312485AbSCUUjw>; Thu, 21 Mar 2002 15:39:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312487AbSCUUjr>; Thu, 21 Mar 2002 15:39:47 -0500
Received: from flaske.stud.ntnu.no ([129.241.56.72]:162 "EHLO
	flaske.stud.ntnu.no") by vger.kernel.org with ESMTP
	id <S312485AbSCUUjU>; Thu, 21 Mar 2002 15:39:20 -0500
Date: Thu, 21 Mar 2002 21:39:17 +0100
From: =?iso-8859-1?Q?Thomas_Lang=E5s?= <tlan@stud.ntnu.no>
To: "David S. Miller" <davem@redhat.com>
Cc: rgooch@ras.ucalgary.ca, laforge@gnumonks.org, skraw@ithnet.com,
        joe@tmsusa.com, linux-kernel@vger.kernel.org, elsner@zrz.TU-Berlin.DE
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020321213917.B20273@stud.ntnu.no>
Reply-To: linux-kernel@vger.kernel.org
In-Reply-To: <20020310163339.H16784@sunbeam.de.gnumonks.org> <20020310.164113.01028736.davem@redhat.com> <200203110055.g2B0tiP24585@vindaloo.ras.ucalgary.ca> <20020310.170338.83978717.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller:
> This may surprise some people, but frankly I think the Tigon3's PCI
> dma engine is junk based upon my current knowledge of the card.  It is
> always possible I may find out something new which kills this
> perception I have of the card, but we'll see...

Is it possible that they've changed this in newer revisions of their
chips?  Why is it junk?  What could've been done better?  What effects has
does the "junky" DMA engine have on the NIC (can there be packet losses when
there's packet bursts, for instance)?

(I'm asking this because we're considering servers which as broadcom NICs
as the only NICs on-board, on the servers).  

-- 
Thomas
