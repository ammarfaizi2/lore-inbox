Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267447AbTBLS2b>; Wed, 12 Feb 2003 13:28:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267454AbTBLS2a>; Wed, 12 Feb 2003 13:28:30 -0500
Received: from phoenix.mvhi.com ([195.224.96.167]:34833 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S267447AbTBLS2a>; Wed, 12 Feb 2003 13:28:30 -0500
Date: Wed, 12 Feb 2003 18:38:12 +0000
From: "'Christoph Hellwig'" <hch@infradead.org>
To: magniett <Frederic.Magniette@lri.fr>
Cc: "Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>,
       "'Christoph Hellwig'" <hch@infradead.org>,
       "Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
       torvalds@transmeta.com, linux-security-module@wirex.com,
       linux-kernel@vger.kernel.org
Subject: Re: [BK PATCH] LSM changes for 2.5.59
Message-ID: <20030212183812.A14810@infradead.org>
Mail-Followup-To: 'Christoph Hellwig' <hch@infradead.org>,
	magniett <Frederic.Magniette@lri.fr>,
	"Makan Pourzandi (LMC)" <Makan.Pourzandi@ericsson.ca>,
	"Stephen D. Smalley" <sds@epoch.ncsc.mil>, greg@kroah.com,
	torvalds@transmeta.com, linux-security-module@wirex.com,
	linux-kernel@vger.kernel.org
References: <7B2A7784F4B7F0409947481F3F3FEF8305CC954F@eammlex037.lmc.ericsson.se> <3E4A9C4D.F580576E@lri.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E4A9C4D.F580576E@lri.fr>; from Frederic.Magniette@lri.fr on Wed, Feb 12, 2003 at 07:11:09PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[argg, any chance you two could get RFC-complaint mailers?]

On Wed, Feb 12, 2003 at 07:11:09PM +0000, magniett wrote:
> exist. For finishing : PLEASE, stop reducing LSM possibilities : it cost a lot to develop things for a hook and then
> redevelopping it for a classical syscall interposition.

There's no one taking away the LSM patches.  Anyway life would be a lot
simpler if you actually announced the stuff you do on lkml instead of hiding
behind the moon.  The only chance hook you need will stay is that you
discuss them publically here.

Where's the pointer to your code?

