Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id <S132126AbRC1S24>; Wed, 28 Mar 2001 13:28:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id <S132128AbRC1S2q>; Wed, 28 Mar 2001 13:28:46 -0500
Received: from cc78409-a.hnglo1.ov.nl.home.com ([213.51.107.234]:48645 "EHLO dexter.hensema.xs4all.nl") by vger.kernel.org with ESMTP id <S132126AbRC1S2d>; Wed, 28 Mar 2001 13:28:33 -0500
Date: Wed, 28 Mar 2001 20:22:45 +0200
From: Erik Hensema <erik@hensema.xs4all.nl>
To: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NTP on 2.4.2?
Message-ID: <20010328202245.B3304@hensema.xs4all.nl>
References: <20010323162345.A24604@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3i
In-Reply-To: <20010323162345.A24604@flint.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2001 at 04:23:45PM +0000, Russell King wrote:
> I'm having problems getting my 2.4.2 kernel to synchronise properly.  For
> some reason, NTP is insisting on making time offset adjustments.

It isn't a GMT vs localtime issue, I presume?
> 
> Is anyone else using NTP with 2.4.2, and if so, are you synchronising
> properly?

Yes, working fine for me.

> (I'm using the RH7.0 version of ntp-4.0.99j here)

Suse 6.3, xntp-4.0.98d-0, mostly vanilla kernel 2.4.2

-- 
Erik Hensema (erik@hensema.xs4all.nl)
