Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312302AbSCTX6d>; Wed, 20 Mar 2002 18:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312304AbSCTX6W>; Wed, 20 Mar 2002 18:58:22 -0500
Received: from mail.bstc.net ([63.90.24.2]:6661 "HELO mail.bstc.net")
	by vger.kernel.org with SMTP id <S312302AbSCTX6L>;
	Wed, 20 Mar 2002 18:58:11 -0500
Date: Thu, 21 Mar 2002 10:57:59 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: "Brendan W. McAdams" <rit@jacked-in.org>
Cc: linux-kernel@vger.kernel.org, linux-wlan-devel@lists.linux-wlan.com,
        dan@telent.net
Subject: Re: [PATCH] Support for Belkin Wireless PCI Adapter (PLX PCI9502 Based) in Kernel >= 2.4.18
Message-ID: <20020320235759.GA10227@zax>
Mail-Followup-To: David Gibson <david@gibson.dropbear.id.au>,
	"Brendan W. McAdams" <rit@jacked-in.org>,
	linux-kernel@vger.kernel.org, linux-wlan-devel@lists.linux-wlan.com,
	dan@telent.net
In-Reply-To: <1016547419.10236.20.camel@mycroft.themunicenter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 09:16:58AM -0500, Brendan W. McAdams wrote:

> I'm not sure who the current "keeper of the flame" is on
> drivers/net/wireless/orinoco_plx.c so I'm submitting this patch to
> any conceivably appropriate places.

That'd be me.


> This patch adds support to the Linux kernel (tested on 2.4.18,
2.4.19-pre3 and 2.4.19-pre3-ac1) for the Belkin F5D6000 "Wireless
Desktop PCI Network Adapter".  This is a PLX PCI9502 based PCMCIA
adapter that allows 802.11b wireless network cards (mainly Prism2
based, like the Belkin F5D6020) to work on desktop boxen.

Applied.

-- 
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

