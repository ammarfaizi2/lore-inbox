Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288455AbSANAj6>; Sun, 13 Jan 2002 19:39:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288463AbSANAjk>; Sun, 13 Jan 2002 19:39:40 -0500
Received: from cj379137-a.indpdnce1.mo.home.com ([24.179.182.153]:49156 "EHLO
	ns.brink.cx") by vger.kernel.org with ESMTP id <S288460AbSANAja>;
	Sun, 13 Jan 2002 19:39:30 -0500
From: Andrew Brink <abrink@ns.brink.cx>
Date: Sun, 13 Jan 2002 18:39:07 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting Out of Memory errors at random intervals.
Message-ID: <20020114003907.GB1406@ns.brink.cx>
In-Reply-To: <20020114003032.GA1356@ns.brink.cx> <E16PvF5-0008Vb-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16PvF5-0008Vb-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On second thought, I went and reviewed some logs.

Happened a lot on one box around 8ish.

On Mon, Jan 14, 2002 at 12:44:51AM +0000, Alan Cox wrote:
> > *Shrug* I've done some experimenting with this, having a lab (30 people)
> > all hit the site at the same time. Holds it fine most the time.  Usually
> > the OOM's come during the middle of the night.
> 
> About 4am by any chance ?
