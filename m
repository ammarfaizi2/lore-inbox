Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272466AbRIFSZS>; Thu, 6 Sep 2001 14:25:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272484AbRIFSZI>; Thu, 6 Sep 2001 14:25:08 -0400
Received: from spike.porcupine.org ([168.100.189.2]:46601 "EHLO
	spike.porcupine.org") by vger.kernel.org with ESMTP
	id <S272466AbRIFSY6>; Thu, 6 Sep 2001 14:24:58 -0400
Subject: Re: notion of a local address [was: Re: ioctl SIOCGIFNETMASK: ip alias
In-Reply-To: <15255.48233.706962.451093@tzadkiel.efn.org> "from Steve VanDevender
 at Sep 6, 2001 11:11:53 am"
To: Steve VanDevender <stevev@efn.org>
Date: Thu, 6 Sep 2001 14:25:18 -0400 (EDT)
Cc: Wietse Venema <wietse@porcupine.org>, linux-kernel@vger.kernel.org
X-Time-Zone: USA EST, 6 hours behind central European time
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20010906182518.3C907BC06C@spike.porcupine.org>
From: wietse@porcupine.org (Wietse Venema)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steve VanDevender:
> Wietse Venema writes:
>  > If an MTA receives a mail relaying request for user@domain.name
>  > then it would be very useful if Linux could provide the MTA with
>  > the necessary information to distinguish between local subnetworks
>  > and the rest of the world. Requiring the local sysadmin to enumerate
>  > all local subnetwork blocks by hand is not practical.
> 
> I think you're making a couple of unjustified assumptions here:

You are making unjustified assumptions:

If the kernel knows about subnets, then an application should be
able to find out about them. Whether or not you agree with the
application's reasons does not matter.

To close with yet another analogy:

A musician complained to Mozart that his music was so difficult to
play. Mozart asked: are these notes on your instrument? The musician
replied: yes. Mozart said: so play these notes.

	Wietse
