Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136256AbRD0Xnb>; Fri, 27 Apr 2001 19:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136263AbRD0XnW>; Fri, 27 Apr 2001 19:43:22 -0400
Received: from pille1.addcom.de ([62.96.128.35]:10756 "HELO pille1.addcom.de")
	by vger.kernel.org with SMTP id <S136256AbRD0XnI>;
	Fri, 27 Apr 2001 19:43:08 -0400
Date: Sat, 28 Apr 2001 01:43:26 +0200 (CEST)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: "David S. Miller" <davem@redhat.com>
cc: Matthias Andree <matthias.andree@gmx.de>,
        Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.4-pre7 build failure w/ IP NAT and ipchains
In-Reply-To: <15081.63650.574602.341411@pizda.ninka.net>
Message-ID: <Pine.LNX.4.33.0104280140400.1256-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Apr 2001, David S. Miller wrote:

> Kai, can you try this patch out?  I think it does the right
> thing.  What I'm mostly interested in is if your ipchains
> setup works for the resulting kernel, I've already checked
> that it links properly. :-)

If you get this mail, it works okay :-) (Just using a simple
masquerading setup here)

--Kai


