Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266749AbSLUHCZ>; Sat, 21 Dec 2002 02:02:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbSLUHCZ>; Sat, 21 Dec 2002 02:02:25 -0500
Received: from codepoet.org ([166.70.99.138]:14988 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S266731AbSLUHCY>;
	Sat, 21 Dec 2002 02:02:24 -0500
Date: Sat, 21 Dec 2002 00:10:31 -0700
From: Erik Andersen <andersen@codepoet.org>
To: "Justin T. Gibbs" <gibbs@scsiguy.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] aic7xxx bouncing over 4G
Message-ID: <20021221071031.GA25566@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	"Justin T. Gibbs" <gibbs@scsiguy.com>, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
References: <200212210012.gBL0Cng21338@eng2.beaverton.ibm.com> <176730000.1040430221@aslan.btc.adaptec.com> <20021221002940.GM25000@holomorphy.com> <190380000.1040432350@aslan.btc.adaptec.com> <20021221013500.GN25000@holomorphy.com> <223910000.1040435985@aslan.btc.adaptec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <223910000.1040435985@aslan.btc.adaptec.com>
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-rmk2, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Dec 20, 2002 at 06:59:46PM -0700, Justin T. Gibbs wrote:
> time and in any granularity.  Linux doesn't give me that freedom so 
> you get this result.  I mean really.  I've only been trying to get
> Marcelo to take the aic79xx driver since May or something.  Give
> me a break.

Supposing I wanted to try out the latest aic7xxx driver?
These are they, right?
    http://people.freebsd.org/~gibbs/linux/SRC/aic79xx-linux-2.4-20021220.bksend.gz

I'm looking at it, and I don't know what it is, bit it sure 
isn't anything I recognize as usable.

    $ file aic79xx-linux-2.4-20021220.bksend 
    aic79xx-linux-2.4-20021220.bksend: ASCII English text

Is the latest aic7xxx driver available as, say, a unified diff,
or a tarball, or some similar usable format?

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
