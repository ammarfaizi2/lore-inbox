Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266381AbRGYBV2>; Tue, 24 Jul 2001 21:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266339AbRGYBVS>; Tue, 24 Jul 2001 21:21:18 -0400
Received: from humbolt.nl.linux.org ([131.211.28.48]:34316 "EHLO
	humbolt.nl.linux.org") by vger.kernel.org with ESMTP
	id <S266377AbRGYBVA>; Tue, 24 Jul 2001 21:21:00 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Nico Schottelius <nicos@pcsystems.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: control pcspeaker
Date: Wed, 25 Jul 2001 02:29:03 +0200
X-Mailer: KMail [version 1.2]
In-Reply-To: <3B5DB131.D16B9826@pcsystems.de>
In-Reply-To: <3B5DB131.D16B9826@pcsystems.de>
MIME-Version: 1.0
Message-Id: <0107250229030B.00520@starship>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

On Tuesday 24 July 2001 19:32, Nico Schottelius wrote:
> Hello Guys!
>
> After some modifcations here is the final (small) patch.

Too small - you seem to have forgotten to attach the patch ;-)

> You can turn on and off the pcspeaker using sysctl calls:
>
> echo 0 > /proc/sys/kernel/pcspeaker # off
>
> echo 1 > /proc/sys/kernel/pcspeaker # on
>
> Alan or Linus, can / will you include this in one of the next
> releases?

Heh, good luck.  I'll apply it to my own system though.  (This patch 
comes up every 6 months or so but I always forget to save a copy.)

--
Daniel
