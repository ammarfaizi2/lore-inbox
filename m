Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291759AbSBHT3q>; Fri, 8 Feb 2002 14:29:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291761AbSBHT3e>; Fri, 8 Feb 2002 14:29:34 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:30223 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S291759AbSBHT3W>; Fri, 8 Feb 2002 14:29:22 -0500
Date: Fri, 8 Feb 2002 16:18:35 -0200 (BRST)
From: Marcelo Tosatti <marcelo@conectiva.com.br>
To: Till Immanuel Patzschke <tip@internetwork-ag.de>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.18-pre9
In-Reply-To: <3C6397C5.5749BF8E@internetwork-ag.de>
Message-ID: <Pine.LNX.4.21.0202081617270.18441-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 8 Feb 2002, Till Immanuel Patzschke wrote:

> Hi Marcelo,
> 
> is there any chance for including the latest PPP patch from Paul (2.4.2 -
> 20020205) and Michael's pppoe patch 0.6.10 -- only those "two" patches eliminate
> the PPP deadlocks!  Might be worth putting these into 2.4.18 final ? :-)

Unfortunately, no. Such patches should be integrated in early -pre series.

2.4.19-pre-early will probably have Paul's PPP fixes.

