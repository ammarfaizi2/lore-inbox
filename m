Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277024AbRJ2RWw>; Mon, 29 Oct 2001 12:22:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276831AbRJ2RWn>; Mon, 29 Oct 2001 12:22:43 -0500
Received: from t2.redhat.com ([199.183.24.243]:61941 "EHLO dot.cygnus.com")
	by vger.kernel.org with ESMTP id <S279301AbRJ2RWa>;
	Mon, 29 Oct 2001 12:22:30 -0500
Date: Mon, 29 Oct 2001 09:21:31 -0800
From: Richard Henderson <rth@redhat.com>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, torvalds@transmeta.com,
        alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: alpha 2.4.13: fix taso osf emulation
Message-ID: <20011029092131.C9074@redhat.com>
In-Reply-To: <20011026013101.A1404@redhat.com> <Pine.GSO.3.96.1011026113847.14048A-100000@delta.ds2.pg.gda.pl> <20011026144522.B18880@jurassic.park.msu.ru> <20011026101145.D1663@redhat.com> <20011029193500.A771@jurassic.park.msu.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011029193500.A771@jurassic.park.msu.ru>; from ink@jurassic.park.msu.ru on Mon, Oct 29, 2001 at 07:35:00PM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 29, 2001 at 07:35:00PM +0300, Ivan Kokshaysky wrote:
> Ok. After converting that from assembly to C I've got your
> version of arch_get_unmapped_area :-)  with small changes
> (to avoid searching the same areas 2 or 3 times).

This looks much better, thanks.


r~
