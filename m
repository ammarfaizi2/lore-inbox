Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129705AbRBGRd0>; Wed, 7 Feb 2001 12:33:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129333AbRBGRdQ>; Wed, 7 Feb 2001 12:33:16 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:28504 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129053AbRBGRc7>; Wed, 7 Feb 2001 12:32:59 -0500
Date: Wed, 7 Feb 2001 12:32:13 -0500
From: Jakub Jelinek <jakub@redhat.com>
To: "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: Gregory Maxwell <greg@linuxpower.cx>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: PCI-SCI Drivers v1.1-7 released
Message-ID: <20010207123213.V16592@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
In-Reply-To: <20010206182501.A23454@vger.timpanogas.org> <20010206190624.C23960@vger.timpanogas.org> <20010206210731.E1110@xi.linuxpower.cx> <20010207110852.A27089@vger.timpanogas.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010207110852.A27089@vger.timpanogas.org>; from jmerkey@vger.timpanogas.org on Wed, Feb 07, 2001 at 11:08:52AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 07, 2001 at 11:08:52AM -0700, Jeff V. Merkey wrote:
> Not supporting #ident for CVS managed code bases would see to 
> me, at first glance, to be a show stopper to shipping a release 
> of anything, since many folks need CVS support.

Could you please explain what you mean by not supporting #ident?
It works just fine for me in all our gcc packages I've checked.

	Jakub
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
