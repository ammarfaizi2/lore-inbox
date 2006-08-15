Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030290AbWHOTBM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030290AbWHOTBM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 15:01:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030457AbWHOTBM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 15:01:12 -0400
Received: from pne-smtpout1-sn1.fre.skanova.net ([81.228.11.98]:65251 "EHLO
	pne-smtpout1-sn1.fre.skanova.net") by vger.kernel.org with ESMTP
	id S1030455AbWHOTBL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 15:01:11 -0400
Date: Tue, 15 Aug 2006 21:00:42 +0200
From: Voluspa <lista1@comhem.se>
To: "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc: lukesharkey@hotmail.co.uk, andi@rhlx01.fht-esslingen.de, davej@redhat.com,
       gene.heskett@verizon.net, ian.stirling@mauve.plus.com,
       linux-kernel@vger.kernel.org, malattia@linux.it
Subject: Re: Touchpad problems with latest kernels
Message-Id: <20060815210042.e0c12553.lista1@comhem.se>
In-Reply-To: <d120d5000608151012y27c1ea2h4adda366112868a7@mail.gmail.com>
References: <d120d5000608141227h7c707686i7db7eabba0e3a3ca@mail.gmail.com>
	<BAY114-F2421131E2BFF6216D9A52BFA4F0@phx.gbl>
	<20060815183310.284d03ae.lista1@comhem.se>
	<d120d5000608151012y27c1ea2h4adda366112868a7@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.4.13; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006 13:12:58 -0400 Dmitry Torokhov wrote:
> On 8/15/06, Voluspa <lista1@comhem.se> wrote:
> >
> > Pointer freezing would be Dmitry's domain, but he'd have to work with
> > someone who can trigger it easily, and who can write scripts to capture
> > debug data, since it's 'hard' to move a frozen pointer to a terminal
> > and issue commands...
> >
> 
> The trick is to have a terminal open and then do alt-tab (presuming
> that it does not unfreeze the pointer)...

Yeah :-) Hitting send a bit too quickly there... But still, from what I
saw of the freezes, they are in the region of 5 to 10 seconds, so
having a prepared script ready (maybe even tied to a key-combo) would
ensure success and ease the stress.

Mvh
Mats Johannesson
