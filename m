Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129355AbRBMLhj>; Tue, 13 Feb 2001 06:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130016AbRBMLh3>; Tue, 13 Feb 2001 06:37:29 -0500
Received: from host217-32-132-155.hg.mdip.bt.net ([217.32.132.155]:47109 "EHLO
	penguin.homenet") by vger.kernel.org with ESMTP id <S129355AbRBMLhW>;
	Tue, 13 Feb 2001 06:37:22 -0500
Date: Tue, 13 Feb 2001 11:34:15 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: lost charaters -- this is becoming annoying!
In-Reply-To: <E14SdTi-0001TE-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.21.0102131133240.927-100000@penguin.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Alan Cox wrote:

> > PS. This only happens on this Dell latitude CPx (notice lost shift in
> > Latitude?) H450GT. 
> > 
> > PPS. No, my laptop is fine -- rebootingnto 2.2.x makes it type without
> > loosing characters...
> 
> 2.2 and 2.4 handle keyboard error cases quite differently (less so as of 2.2.18)
> When you say 2.2.x works does that include 2.2.18.

no, I meant the plain 2.2.x as of Red Hat 7.0 which is labelled as
"2.2.16-22".

> 
> The next stage then is probably to log when you see errored keyboard bytes
> 

ok.

Regards,
Tigran


