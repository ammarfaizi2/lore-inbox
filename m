Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280806AbRKOJ66>; Thu, 15 Nov 2001 04:58:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280804AbRKOJ6s>; Thu, 15 Nov 2001 04:58:48 -0500
Received: from pizda.ninka.net ([216.101.162.242]:63373 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S280803AbRKOJ6p>;
	Thu, 15 Nov 2001 04:58:45 -0500
Date: Thu, 15 Nov 2001 01:58:36 -0800 (PST)
Message-Id: <20011115.015836.55572138.davem@redhat.com>
To: sgy@amc.com.au
Cc: linux-kernel@vger.kernel.org
Subject: Re: What Athlon chipset is most stable in Linux?
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <5.1.0.14.0.20011115111324.01f0c540@mail.amc.localnet>
In-Reply-To: <Pine.LNX.4.30.0111131910440.9658-100000@anime.net>
	<20011113.191607.00304518.davem@redhat.com>
	<5.1.0.14.0.20011115111324.01f0c540@mail.amc.localnet>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You won't see the problem with the GeForce3 because it has stricter
AGP timings.

The problem is going to show up with cards that are a little bit out
of the AGP spec, this includes the Radeon and the GeForce2.

Franks a lot,
David S. Miller
davem@redhat.com
