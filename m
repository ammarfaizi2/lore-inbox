Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285229AbSCOIjA>; Fri, 15 Mar 2002 03:39:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285692AbSCOIiu>; Fri, 15 Mar 2002 03:38:50 -0500
Received: from adsl-64-169-88-198.dsl.snfc21.pacbell.net ([64.169.88.198]:37767
	"EHLO fokker") by vger.kernel.org with ESMTP id <S285229AbSCOIik>;
	Fri, 15 Mar 2002 03:38:40 -0500
Message-ID: <3C91B30D.A887A033@ianduggan.net>
Date: Fri, 15 Mar 2002 00:38:37 -0800
From: Ian Duggan <ian@ianduggan.net>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18+mki+w4l i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Robert Love <rml@tech9.net>,
        linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 Preempt Freezeups
In-Reply-To: <3C9153A7.292C320@ianduggan.net> <E16lhBg-0002Yc-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox wrote:
> 
> > Stock 2.4.18+preempt+mki-adapter+win4lin
> >       - Very frequent, and also repeatable every time I
> >               try to start win4lin.
> 
> pre-empt is almost certainly going to break things like win4lin

What is required for preempt beyond "SMP safe" code? I thought the whole
idea was to make the preemptions transparent to other code by utilizing
the SMP critical regions?

-- Ian

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Ian Duggan                    ian@ianduggan.net
                              http://www.ianduggan.net
