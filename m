Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288298AbSAMXhd>; Sun, 13 Jan 2002 18:37:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288310AbSAMXhY>; Sun, 13 Jan 2002 18:37:24 -0500
Received: from cj379137-a.indpdnce1.mo.home.com ([24.179.182.153]:23812 "EHLO
	ns.brink.cx") by vger.kernel.org with ESMTP id <S288298AbSAMXhJ>;
	Sun, 13 Jan 2002 18:37:09 -0500
From: Andrew Brink <abrink@ns.brink.cx>
Date: Sun, 13 Jan 2002 17:36:47 -0600
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Getting Out of Memory errors at random intervals.
Message-ID: <20020113233647.GA1198@ns.brink.cx>
In-Reply-To: <20020113232630.GA1149@ns.brink.cx> <E16PuJq-0008NF-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16PuJq-0008NF-00@the-village.bc.nu>
User-Agent: Mutt/1.3.24i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 13, 2002 at 11:45:42PM +0000, Alan Cox wrote:
> Run something that has a sane VM in all the known awkward cases (eg the Red Hat
> 2.4.9 tree) and you should be just fine. If not I'd be interested to know

I take it the vanilla 2.4.9 would also do?

> 
> For the newer trees I can only get stability under high loads with either the
> Andrea -aa vm patches or Rik's rmap-11b patch. Both of which seem to help
> no end.

As for High loads....these boxes don't even get a load.

Andrew

