Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129212AbRBUOFx>; Wed, 21 Feb 2001 09:05:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129216AbRBUOFn>; Wed, 21 Feb 2001 09:05:43 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:34564 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S129212AbRBUOFh>;
	Wed, 21 Feb 2001 09:05:37 -0500
Date: Wed, 21 Feb 2001 11:05:33 -0300
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] VIA 4.2x driver for 2.2 kernels
Message-ID: <20010221110533.B3374@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010220134028.A5762@suse.cz> <20010220155927.A1543@cm.nu> <20010221080919.A469@suse.cz> <20010220231502.A4618@cm.nu> <20010221082348.A908@suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <20010221082348.A908@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 21 2001, Vojtech Pavlik wrote:
> On Tue, Feb 20, 2001 at 11:15:02PM -0800, Shane Wegner wrote:
> > Ok, can I still use -u1 -k1 -c1 on the drives or is it even
> > necessary anymore.
> 
> If you enable automatic DMA in the kernel config, it isn't necessary
> at all. The VIA driver sets up everything.

	Ok. Please disregard my last message (this one contains
	exactly what I was looking for).

> 4) But VIA is still set to PIO mode

	Why does this happen?

	And what about the other options to hdparm (-u1 -k1 -c1)? Are
	they potentially dangerous also?


	[]s, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
