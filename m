Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264192AbUGLXIc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264192AbUGLXIc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jul 2004 19:08:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264206AbUGLXIb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jul 2004 19:08:31 -0400
Received: from mail.gurulabs.com ([67.137.148.7]:39600 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S264192AbUGLXIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jul 2004 19:08:20 -0400
Subject: Re: [ltp] Re: pcmcia on the T42p
From: Dax Kelson <dax@gurulabs.com>
To: linux-thinkpad@linux-thinkpad.org
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1089668369.3848.25.camel@mentorng.gurulabs.com>
References: <Pine.LNX.4.58.0407102320180.1145@t42p>
	 <1089668369.3848.25.camel@mentorng.gurulabs.com>
Content-Type: text/plain
Message-Id: <1089673712.3860.8.camel@mentorng.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 12 Jul 2004 17:08:32 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-07-12 at 15:39, Dax Kelson wrote:
> On Sun, 2004-07-11 at 00:27, Rasmus Lerdorf wrote:
> > You mentioned you couldn't get your T42 to see any pcmcia events with a
> > Cisco Aironet 350 card.  I just tried it on mine and it worked fine.  I
> > didn't boot with it and plugged it in and it came right up.  cardctl eject
> > and re-inserted it about 10 times and each time it came back up fine.
> 
> More details and resolution.


I may have spoke too soon. 

When I say "not working" I mean that physically inserting the card
causes no hotplug activity to happen. If I do a "cardctl insert" then
card is brought up.

With a IBM T4X do you have to use "cardctl insert" or is just sliding
the card in enough? For a period of time earlier today just sliding the
card in was enough. I can't get that behavior back though.

Dax Kelson


