Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284182AbRLKX6h>; Tue, 11 Dec 2001 18:58:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284200AbRLKX60>; Tue, 11 Dec 2001 18:58:26 -0500
Received: from borderworlds.dk ([193.162.142.101]:14341 "HELO
	klingon.borderworlds.dk") by vger.kernel.org with SMTP
	id <S284182AbRLKX6Q>; Tue, 11 Dec 2001 18:58:16 -0500
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: skraw@ithnet.com (Stephan von Krawczynski), linux-kernel@vger.kernel.org
Subject: Re: NULL pointer dereference in moxa driver
In-Reply-To: <E16DwgD-0007R1-00@the-village.bc.nu>
From: Christian Laursen <xi@borderworlds.dk>
Date: 12 Dec 2001 00:58:12 +0100
In-Reply-To: <E16DwgD-0007R1-00@the-village.bc.nu>
Message-ID: <m3d71lfgx7.fsf@borg.borderworlds.dk>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> > Most interestingly the moxa-driver is better by far than the mxser. It
> > seems to me the mxser is _really_ old. If you want to help us all,    
> 
> mxser, like the boards the moxa mxser driver supports is very old.

Those boards are still sold though. We bought ours quite recently.

At least they both work now, with Stephan's patch applied.

-- 
Best regards
    Christian Laursen
