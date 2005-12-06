Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030309AbVLFXp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030309AbVLFXp0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 18:45:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030308AbVLFXp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 18:45:26 -0500
Received: from mail.dvmed.net ([216.237.124.58]:41114 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1030306AbVLFXpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 18:45:25 -0500
Message-ID: <43962281.2050707@pobox.com>
Date: Tue, 06 Dec 2005 18:45:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: laforge@gnumonks.org, davej@redhat.com, jbenc@suse.cz, josejx@gentoo.org,
       mbuesch@freenet.de, linux-kernel@vger.kernel.org,
       bcm43xx-dev@lists.berlios.de, netdev@vger.kernel.org
Subject: Re: Broadcom 43xx first results
References: <4394902C.8060100@pobox.com>	<20051205195329.GB19964@redhat.com>	<20051206151046.GF4038@rama.exocore.com> <20051206.151919.72043193.davem@davemloft.net>
In-Reply-To: <20051206.151919.72043193.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  David S. Miller wrote: > I'm at the point where I
	frankly don't care which softmac > implementation we go with, but
	rather I'm more concerned that we pick > _ONE_ and just stick with it,
	and then adding the necessary interfaces > and infrastructure as
	different wireless devices require. > > Yes, you hear me right, it's
	more important to agree to one > implementation as the basis, even if
	it's the worst one currently. > Division of labor is something we
	simply cannot afford on the wireless > stack at this time. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> I'm at the point where I frankly don't care which softmac
> implementation we go with, but rather I'm more concerned that we pick
> _ONE_ and just stick with it, and then adding the necessary interfaces
> and infrastructure as different wireless devices require.
> 
> Yes, you hear me right, it's more important to agree to one
> implementation as the basis, even if it's the worst one currently.
> Division of labor is something we simply cannot afford on the wireless
> stack at this time.

Agreed.

	Jeff


