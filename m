Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262210AbSK0KxC>; Wed, 27 Nov 2002 05:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262215AbSK0KxC>; Wed, 27 Nov 2002 05:53:02 -0500
Received: from boden.synopsys.com ([204.176.20.19]:24007 "HELO
	boden.synopsys.com") by vger.kernel.org with SMTP
	id <S262210AbSK0Kw7>; Wed, 27 Nov 2002 05:52:59 -0500
Date: Wed, 27 Nov 2002 12:00:01 +0100
From: Alex Riesen <Alexander.Riesen@synopsys.com>
To: Young-Ho Cha <ganadist@nakyup.mizi.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.49 module problem
Message-ID: <20021127110001.GB27097@riesen-pc.gr05.synopsys.com>
Reply-To: Alexander.Riesen@synopsys.com
References: <20021126193026.Q14666-100000@sorrow.ashke.com> <1038362008.2594.112.camel@irongate.swansea.linux.org.uk> <20021127043532.GA25666@nakyup.mizi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021127043532.GA25666@nakyup.mizi.com>
User-Agent: Mutt/1.4i
Organization: Synopsys, Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 27, 2002 at 01:35:32PM +0900, Young-Ho Cha wrote:
> > > I recently upgraded my motherboard to one with an ICH4 IDE controller.
> > > Since it's not supported in 2.4.*, yet, I decided now would be a good time
> > 2.5.49 needs new very different module tools
> > 
> I use rusty's module init tools with modutils 2.4.22.
> But many modules cannot load.
> attach some list of modules that kernel cannot load.

> FATAL: Error inserting /lib/modules/2.5.49-ac2/kernel/ac97_codec.o: Invalid module format

see http://marc.theaimsgroup.com/?l=linux-kernel&m=103815193017700&w=2

