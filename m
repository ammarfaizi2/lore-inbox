Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132938AbRDERZR>; Thu, 5 Apr 2001 13:25:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132941AbRDERY6>; Thu, 5 Apr 2001 13:24:58 -0400
Received: from firewall.spacetec.no ([192.51.5.5]:11481 "EHLO
	pallas.spacetec.no") by vger.kernel.org with ESMTP
	id <S132938AbRDERYy>; Thu, 5 Apr 2001 13:24:54 -0400
Date: Thu, 5 Apr 2001 19:24:10 +0200
Message-Id: <200104051724.TAA09779@pallas.spacetec.no>
Mime-Version: 1.0
X-Newsreader: knews 0.9.8
In-Reply-To: <fa.j9vo8pv.1rj8up9@ifi.uio.no>
    <fa.dkui9av.1ulsbjm@ifi.uio.no>
In-Reply-To: <fa.dkui9av.1ulsbjm@ifi.uio.no>
From: tor@spacetec.no (Tor Arntsen)
Subject: Re: [QUESTION] 2.4.x nice level
X-Original-Newsgroups: fa.linux.kernel
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

LA Walsh <law@sgi.com> writes:
>	I was running 2 copies of setiathome on a 4 CPU server
>@ work.  The two processes ran nice'd -19.  The builds we were 
>running still took 20-30% longer as opposed to when setiathome wasn't
>running (went from 45 minutes up to about an hour).  This machine
>has 1G, so I don't think it was hurting from swapping.

It would be nice to have IRIX weightless processes on Linux.. 
setiathome on SGI computers don't affect anything else except
in extreme cases.

-Tor
