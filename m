Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129159AbRBMTzv>; Tue, 13 Feb 2001 14:55:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbRBMTzm>; Tue, 13 Feb 2001 14:55:42 -0500
Received: from 200-221-84-35.dsl-sp.uol.com.br ([200.221.84.35]:40964 "HELO
	dumont.rtb.ath.cx") by vger.kernel.org with SMTP id <S129583AbRBMTzi>;
	Tue, 13 Feb 2001 14:55:38 -0500
Date: Tue, 13 Feb 2001 17:55:33 -0200
From: Rogerio Brito <rbrito@iname.com>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.x SMP blamed for Xfree 4.0 crashes
Message-ID: <20010213175532.C4399@iname.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <XFMail.20010213130505.gale@syntax.dera.gov.uk> <E14SfKk-0001kl-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <E14SfKk-0001kl-00@the-village.bc.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Feb 13 2001, Alan Cox wrote:
> Yeah I've seen this claim repeatedly. XFree 4.0.2 crashes for me in similar
> ways on 3dfx and matrox cards and it happens with 2.2 kernels as well.

	I thought that I was going crazy or that it was just my
	inability to configure things correctly, but it is kind of
	comforting to see that I'm not the only one seeing problems
	with XFree86 4.0.2 + matrox + kernel 2.2.18 (UP system -- an
	AMD Duron with chipset KT133).

	When X 4.0.2 entered the Debian testing distribution, I
	immediately upgraded (I had used X 4.0.1 before with very good
	results, but that system had an HD crash and I reinstalled
	Debian potato, that comes with X 3.3.6). I got all these
	strange Segfaults and crashes with a vanilla 2.2.18 kernel. I
	went back to X 3.3.6 and everything is running perfectly fine
	since then, but I'd like to use the new features of X 4.


	[]s, Roger...

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogerio Brito - rbrito@iname.com - http://www.ime.usp.br/~rbrito/
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
