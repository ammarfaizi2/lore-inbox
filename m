Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276631AbRJBTNn>; Tue, 2 Oct 2001 15:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276635AbRJBTNd>; Tue, 2 Oct 2001 15:13:33 -0400
Received: from ppp-3055-M5-238.dialup.eol.ca ([64.56.224.238]:30212 "EHLO
	node0.opengeometry.ca") by vger.kernel.org with ESMTP
	id <S276631AbRJBTNZ>; Tue, 2 Oct 2001 15:13:25 -0400
Date: Tue, 2 Oct 2001 15:12:12 -0400
From: William Park <opengeometry@yahoo.ca>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: PLIP on thinkpad 560E
Message-ID: <20011002151212.D831@node0.opengeometry.ca>
Mail-Followup-To: Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <15289.60336.765914.654516@titan.home.hindley.uklinux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <15289.60336.765914.654516@titan.home.hindley.uklinux.net>; from mark@hindley.uklinux.net on Tue, Oct 02, 2001 at 05:30:40PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 05:30:40PM +0100, Mark Hindley wrote:
> 
> Does anybody know if PLIP works on a thinkpad 560E. I can't get it to!
> 
> I am using 2.4.10.
> 
> The packets are received, but the sending seems to fail:
> 
> Logs:
> Oct  2 17:18:42 localhost kernel: plip0: transmit timeout(1,87)
> Oct  2 17:18:43 localhost kernel: plip0: transmit timeout(1,87)

I used to get this message with 2.2.x, but files still moved between
desktop and laptop.  I haven't tried with 2.4.x.

-- 
William Park, Open Geometry Consulting, <opengeometry@yahoo.ca>
8 CPU cluster, (Slackware) Linux, Python, LaTeX, Vim, Mutt, Sc.
