Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269795AbRH1APC>; Mon, 27 Aug 2001 20:15:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269831AbRH1AOx>; Mon, 27 Aug 2001 20:14:53 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:30215 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S269795AbRH1AOn>; Mon, 27 Aug 2001 20:14:43 -0400
Date: Mon, 27 Aug 2001 19:46:56 -0300 (BRT)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Adrian Bunk <bunk@fs.tum.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: VM: Bad swap entry 0044cb00
In-Reply-To: <Pine.NEB.4.33.0108280204430.13898-100000@mimas.fachschaften.tu-muenchen.de>
Message-ID: <Pine.LNX.4.21.0108271946300.7385-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Aug 2001, Adrian Bunk wrote:

> Hi,
> 
> I upgraded my kernel from 2.4.8ac10 to 2.4.9ac2 some hours ago and I found
> the following message in my syslog file (I've never seen something like
> this before):
> 
> Aug 27 22:40:46 r063144 kernel: VM: Bad swap entry 0044cb00
> 
> 
> What does this mean (my machine seems to run fine)?

Did you turned any swap file/partition off? (with swapoff) 

