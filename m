Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266469AbSKGKfK>; Thu, 7 Nov 2002 05:35:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266477AbSKGKfJ>; Thu, 7 Nov 2002 05:35:09 -0500
Received: from outpost.ds9a.nl ([213.244.168.210]:11205 "EHLO outpost.ds9a.nl")
	by vger.kernel.org with ESMTP id <S266469AbSKGKfI>;
	Thu, 7 Nov 2002 05:35:08 -0500
Date: Thu, 7 Nov 2002 11:41:47 +0100
From: bert hubert <ahu@ds9a.nl>
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Silly advise in bridge Configure help
Message-ID: <20021107104147.GA22486@outpost.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
References: <3DC9EA2A.142559AA@verizon.net> <20021107.011526.120464470.davem@redhat.com> <20021107091822.GA21030@outpost.ds9a.nl> <20021107.014953.58440275.davem@redhat.com> <20021107103905.GA22139@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021107103905.GA22139@outpost.ds9a.nl>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 07, 2002 at 11:39:05AM +0100, bert hubert wrote:
> > If you take Linus's current BK tree, and apply the patch below, you
> > can begin trying to use the racoon and other KAME tools that we
> > 'ported' at:
> 
> This also appears to need some changes in the crypto api:

Apologies, the patch does apply without --dry-run

-- 
http://www.PowerDNS.com          Versatile DNS Software & Services
http://lartc.org           Linux Advanced Routing & Traffic Control HOWTO
