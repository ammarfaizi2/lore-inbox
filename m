Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279113AbRKMNvJ>; Tue, 13 Nov 2001 08:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279180AbRKMNvA>; Tue, 13 Nov 2001 08:51:00 -0500
Received: from as2-1-8.va.g.bonet.se ([194.236.117.122]:2052 "EHLO
	boris.prodako.se") by vger.kernel.org with ESMTP id <S279113AbRKMNuq>;
	Tue, 13 Nov 2001 08:50:46 -0500
Date: Tue, 13 Nov 2001 14:50:38 +0100 (CET)
From: Tobias Ringstrom <tori@ringstrom.mine.nu>
X-X-Sender: <tori@boris.prodako.se>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Marcelo Borges Ribeiro <marcelo@datacom-telematica.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: via82cxxx_audio problems
In-Reply-To: <E163cqd-00012s-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0111131441100.1452-100000@boris.prodako.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Nov 2001, Alan Cox wrote:

> > in dmesg) and cannot play in any other rate. With mplayer you can see
> > messages such as requested 16000Hz got (480000) that explains why it so=
> > unds
> > like chip'n'dale ;-). P.s. I don=B4t know why it works with xmms  but w=
> > ith
> > mpg123 it refuses to play at all becouse these sound rates.
> 
> XMMS does the right thing. It understands how to do rate adaption. 

Only if you use the OSS module for output.  Using esound (which is the
default in RH 7.2) it sounds terrible.  That might be esound's fault 
though.

/Tobias

