Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287498AbRLaMUA>; Mon, 31 Dec 2001 07:20:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287496AbRLaMTu>; Mon, 31 Dec 2001 07:19:50 -0500
Received: from d-dialin-2803.addcom.de ([213.61.81.171]:15600 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S287495AbRLaMTk>; Mon, 31 Dec 2001 07:19:40 -0500
Date: Mon, 31 Dec 2001 13:19:34 +0100 (CET)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: <kai@vaio>
To: Dave Jones <davej@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: merge in progress.
In-Reply-To: <20011231031506.A1537@suse.de>
Message-ID: <Pine.LNX.4.33.0112311306450.1366-100000@vaio>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Dec 2001, Dave Jones wrote:

> Pending:
> o  Lots of driver updates for ieee1394, ISDN, network drivers, parport
>    & paride, USB, MTD.  Hopefully the larger subsystems like USB will
>    get pushed by the relevant maintainers who can explain their bits
>    to Linus a lot better than I can.

I'll take care of ISDN. Should I include the ISDN __devexit changes, or do 
you want to push all of these in one batch?

--Kai



