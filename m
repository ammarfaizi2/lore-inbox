Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282785AbRK0EY1>; Mon, 26 Nov 2001 23:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282786AbRK0EYS>; Mon, 26 Nov 2001 23:24:18 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:2033
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S282785AbRK0EYI>; Mon, 26 Nov 2001 23:24:08 -0500
Date: Mon, 26 Nov 2001 20:23:59 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Louis Garcia <louisg00@bellsouth.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PNP Bios
Message-ID: <20011126202359.B26219@mikef-linux.matchmail.com>
Mail-Followup-To: Louis Garcia <louisg00@bellsouth.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <1006831443.5051.0.camel@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1006831443.5051.0.camel@tiger>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 26, 2001 at 10:24:02PM -0500, Louis Garcia wrote:
> > > >From the -ac tree are we going to bring over the PNP Bio?s if so I
> > > would
> > > like to bring them up to date if that would be OK.
> > > I?m a NEW Kernel Developer wanting to get my hands dirty.
> > 
> > I plan to submit PnP BIOS to 2.5 but not 2.4 - it needs more study yet
> 
> 
> I thought ACPI is going to replace PNP Bios in the future?
> 
> Louis

ACPI will replace APM, but APM will be needed to support the older hardware.

I don't think ACPI will replace Plug 'n Play.

MF
