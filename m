Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289912AbSAOPAo>; Tue, 15 Jan 2002 10:00:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289882AbSAOPAe>; Tue, 15 Jan 2002 10:00:34 -0500
Received: from ns.ithnet.com ([217.64.64.10]:1031 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id <S289881AbSAOPAZ>;
	Tue, 15 Jan 2002 10:00:25 -0500
Date: Tue, 15 Jan 2002 16:00:18 +0100
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Klaus Meyer <k.meyer@m3its.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: highmem=system killer, 2.2.17=performance killer ?
Message-Id: <20020115160018.18793569.skraw@ithnet.com>
In-Reply-To: <3C439E6D.B2B8C5B8@m3its.de>
In-Reply-To: <3C439E6D.B2B8C5B8@m3its.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.7.0 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Jan 2002 04:13:49 +0100
Klaus Meyer <k.meyer@m3its.de> wrote:

> i've got serious problems using 2.4.x kernels using highmem support.
> It seems to me that i'm not the only one, but the difference to most
> other ones is,
> that i can't use highmem because the system performance is terrible
> slow.
> 
> the testbed:
> 1) Asus CUR-DLS (Server Set LE III) with two 1Ghz Pentiums, 2GB of ram

Interestingly I have about the same setup and use, only I transfer about 25 GB
a day via nfs to an Asus CUV4XD with 2 GB under 2.4.18-pre3 and do not
experience any problem so far. I haven't had any with 2.4.17, too. Cache is
pretty heavy used, but I experience no slowdown or other weird things. Can this
be somehow chipset related? Maybe something about the DGE cards? I am using TP
100MBit tulip-based.

Regards,
Stephan


