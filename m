Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136483AbREGSPI>; Mon, 7 May 2001 14:15:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136514AbREGSO7>; Mon, 7 May 2001 14:14:59 -0400
Received: from a1a90191.sympatico.bconnected.net ([209.53.18.14]:34945 "EHLO
	a1a90191.sympatico.bconnected.net") by vger.kernel.org with ESMTP
	id <S136483AbREGSOv>; Mon, 7 May 2001 14:14:51 -0400
Date: Mon, 7 May 2001 11:14:36 -0700
From: Shane Wegner <shane@cm.nu>
To: Johannes Erdfelt <jerdfelt@valinux.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: 2.2.20pre1: Problems with SMP
Message-ID: <20010507111436.A17314@cm.nu>
In-Reply-To: <20010506175050.A1968@cm.nu> <E14wiNn-0003JF-00@the-village.bc.nu> <20010507102053.A2276@cm.nu> <20010507110250.H903@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <20010507110250.H903@valinux.com>; from jerdfelt@valinux.com on Mon, May 07, 2001 at 11:02:50AM -0700
Organization: Continuum Systems, Vancouver, Canada
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2001 at 11:02:50AM -0700, Johannes Erdfelt wrote:
> On Mon, May 07, 2001, Shane Wegner <shane@cm.nu> wrote:
> > 
> > That does indeed correct the problem.  2.2.20pre1 now works
> > as expected.
> 
> Hmm, that uses a VIA based chipset. I didn't know they did SMP yet. Does
> 2.4 work on this system?

The last 2.4 kernel I tried was 2.4.3 I believe and it
worked fine more or less.  I haven't tried any later 2.4
kernels yet.

Shane


-- 
Shane Wegner: shane@cm.nu
              http://www.cm.nu/~shane/
PGP:          1024D/FFE3035D
              A0ED DAC4 77EC D674 5487
              5B5C 4F89 9A4E FFE3 035D
