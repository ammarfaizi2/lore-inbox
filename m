Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261866AbRFEKOf>; Tue, 5 Jun 2001 06:14:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262090AbRFEKOZ>; Tue, 5 Jun 2001 06:14:25 -0400
Received: from homebase.cluenet.de ([195.247.6.184]:20485 "HELO
	homebase.cluenet.de") by vger.kernel.org with SMTP
	id <S261866AbRFEKON>; Tue, 5 Jun 2001 06:14:13 -0400
Date: Tue, 5 Jun 2001 12:14:10 +0200
From: Daniel Roesen <dr@bofh.de>
To: linux-kernel@vger.kernel.org
Subject: Re: TRG vger.timpanogas.org hacked
Message-ID: <20010605121410.B26736@homebase.cluenet.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20010604183642.A855@vger.timpanogas.org> <E157AuE-0006Wc-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E157AuE-0006Wc-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jun 05, 2001 at 08:05:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2001 at 08:05:34AM +0100, Alan Cox wrote:
> > is curious as to how these folks did this.  They exploited BIND 8.2.3
> > to get in and logs indicated that someone was using a "back door" in 
> 
> Bind runs as root.

Not if set up properly. And there is no known hole in BIND 8.2.3-REL
so I'm wondering how Jeff found out that the intruder got in via BIND.
