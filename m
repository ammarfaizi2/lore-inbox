Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292057AbSBTRUy>; Wed, 20 Feb 2002 12:20:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292055AbSBTRUo>; Wed, 20 Feb 2002 12:20:44 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:62710
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292043AbSBTRU3>; Wed, 20 Feb 2002 12:20:29 -0500
Date: Wed, 20 Feb 2002 09:20:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Ville Herva <vherva@twilight.cs.hut.fi>,
        george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: jiffies rollover, uptime etc.
Message-ID: <20020220172052.GA15228@matchmail.com>
Mail-Followup-To: Ville Herva <vherva@niksula.cs.hut.fi>,
	george anzinger <george@mvista.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1020218191149.14047A-100000@gatekeeper.tmr.com> <3C72BBBA.FB79F6D0@mvista.com> <20020220113602.GN1105@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020220113602.GN1105@niksula.cs.hut.fi>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2002 at 01:36:02PM +0200, Ville Herva wrote:
> asm-ia64/param.h:# define HZ    1024
> asm-x86_64/param.h:#define HZ 100
>

What's the difference between these two architectures?  Intel 64bit
processor and AMD's upcoming 64bit processor?

Mike
