Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288494AbSANAqs>; Sun, 13 Jan 2002 19:46:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288499AbSANAql>; Sun, 13 Jan 2002 19:46:41 -0500
Received: from cj379137-a.indpdnce1.mo.home.com ([24.179.182.153]:52740 "EHLO
	ns.brink.cx") by vger.kernel.org with ESMTP id <S288494AbSANAp4>;
	Sun, 13 Jan 2002 19:45:56 -0500
From: Andrew Brink <abrink@ns.brink.cx>
Date: Sun, 13 Jan 2002 18:45:28 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting Out of Memory errors at random intervals.
Message-ID: <20020114004528.GA1534@ns.brink.cx>
In-Reply-To: <20020114003907.GB1406@ns.brink.cx> <E16PvMS-00005i-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16PvMS-00005i-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Will do. However, might be a while, since this isn't reproducable on
demand.

On Mon, Jan 14, 2002 at 12:52:28AM +0000, Alan Cox wrote:
> > On Mon, Jan 14, 2002 at 12:44:51AM +0000, Alan Cox wrote:
> > > > *Shrug* I've done some experimenting with this, having a lab (30 people)
> > > > all hit the site at the same time. Holds it fine most the time.  Usually
> > > > the OOM's come during the middle of the night.
> > > 
> > > About 4am by any chance ?
> > 
> > On second thought, I went and reviewed some logs.
> > Happened a lot on one box around 8ish.
> > 
> 
> Ok. Let me know how trying the other things work (also the list). I'm sure
> Andrea, Marcelo and Rik all want to look at these cases
