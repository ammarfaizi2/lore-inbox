Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130344AbRARLQD>; Thu, 18 Jan 2001 06:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130913AbRARLPx>; Thu, 18 Jan 2001 06:15:53 -0500
Received: from jalon.able.es ([212.97.163.2]:59616 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S130344AbRARLPm>;
	Thu, 18 Jan 2001 06:15:42 -0500
Date: Thu, 18 Jan 2001 12:15:29 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Josh Myer <josh@joshisanerd.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: 128M memory OK, but with 192M sound card es1391 trouble
Message-ID: <20010118121529.A715@werewolf.able.es>
In-Reply-To: <Pine.LNX.4.30.0101172037310.1309-100000@thor.gds-corp.com> <20010118002551.C883@werewolf.able.es> <20010117043619.B23406@grace>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010117043619.B23406@grace>; from josh@joshisanerd.com on Wed, Jan 17, 2001 at 11:36:19 +0100
X-Mailer: Balsa 1.0.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2001.01.17 Josh Myer wrote:
> 
> My guess is that JA's console player doesn't move around as much memory as
> the gnome one (imagine that), therefore produces less memory noise.

No, that is the problem. It is just the same player, just launched from
the command line (also opens his gnome window, doees not fall back to a
terminal look) or pushing a button... That is what I don't understand.

-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.0-ac9 #2 SMP Sun Jan 14 01:46:07 CET 2001 i686

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
