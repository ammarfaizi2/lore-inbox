Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276329AbRJYUv4>; Thu, 25 Oct 2001 16:51:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276331AbRJYUvs>; Thu, 25 Oct 2001 16:51:48 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:19964 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S276329AbRJYUvi>; Thu, 25 Oct 2001 16:51:38 -0400
Date: Thu, 25 Oct 2001 16:52:04 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Martin Josefsson <gandalf@wlug.westbo.se>,
        Samium Gromoff <_deepfire@mail.ru>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.12-ac4 10Mbit NE2k interrupt load kills p166
Message-ID: <20011025165204.K23000@redhat.com>
In-Reply-To: <Pine.LNX.4.21.0110252234270.27907-100000@tux.rsn.bth.se> <E15wrWY-0006EJ-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E15wrWY-0006EJ-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Thu, Oct 25, 2001 at 09:54:46PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 25, 2001 at 09:54:46PM +0100, Alan Cox wrote:
> A faster machine will take as long as a slow machine with an ne2000. It
> doesn't matter if its an 8Mb 386 or a dual athlon, it will spend almost all
> of its ne2000 handling time poking bytes across an 8MHz bus.

Put another way: if you want a kernel that's optimised for 386es, use 2.0.

		-ben
