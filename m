Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264421AbRFZK5l>; Tue, 26 Jun 2001 06:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264401AbRFZK5b>; Tue, 26 Jun 2001 06:57:31 -0400
Received: from nat-pool-meridian.redhat.com ([199.183.24.200]:51741 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S264421AbRFZK5R>; Tue, 26 Jun 2001 06:57:17 -0400
Date: Tue, 26 Jun 2001 11:56:51 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Ville Herva <vherva@mail.niksula.cs.hut.fi>
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org,
        Florian Lohoff <flo@rfc822.org>
Subject: Re: Oops in iput
Message-ID: <20010626115651.A9176@redhat.com>
In-Reply-To: <20010625201612.A701@paradigm.rfc822.org> <20010625194213.J18856@redhat.com> <20010626110933.R1503@niksula.cs.hut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010626110933.R1503@niksula.cs.hut.fi>; from vherva@mail.niksula.cs.hut.fi on Tue, Jun 26, 2001 at 11:09:33AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Jun 26, 2001 at 11:09:33AM +0300, Ville Herva wrote:

> Well, I for one use the 2.2 ide patches extensively (on almost all of my
> machines, including a heavy-duty backup server)

It is highly hardware-dependent.  A huge amount of effort was spent
early in 2.4 getting blacklists and hardware tweaks right to work
around problems with specific chipsets with ide udma.  Just because it
works for one person doesn't give you any confidence that it won't
trash data for somebody else.

Cheers,
 Stephen
