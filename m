Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292339AbSBYVzY>; Mon, 25 Feb 2002 16:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292348AbSBYVzT>; Mon, 25 Feb 2002 16:55:19 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:48381
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S292336AbSBYVyZ>; Mon, 25 Feb 2002 16:54:25 -0500
Date: Mon, 25 Feb 2002 13:54:52 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: John Stoffel <stoffel@casc.com>
Cc: DevilKin <DevilKin-LKML@blindguardian.org>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18
Message-ID: <20020225215452.GB27211@matchmail.com>
Mail-Followup-To: John Stoffel <stoffel@casc.com>,
	DevilKin <DevilKin-LKML@blindguardian.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.21.0202251613300.31438-100000@freak.distro.conectiva> <20020225203750.C531B218392@tartarus.telenet-ops.be> <15482.44226.126189.431079@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <15482.44226.126189.431079@gargle.gargle.HOWL>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 25, 2002 at 04:29:38PM -0500, John Stoffel wrote:
> 
> DevilKin> Wouldn't it be easier just to make a new 2.4.18 with the
> DevilKin> patch applied?
> 
> Or just release 2.4.19 right away with the patch applied and start all
> over again on 2.4.20-pre1 instead?
> 

You have got to be kidding me.

The only binaries that are affected are ones compiles without shared
libraries on some non-x86 arches, and anyone doing that should know what
they are doing and which kernels to use.

Does anyone know how long this bug has been in the kernel?

Mike
