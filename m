Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265369AbSKNWXo>; Thu, 14 Nov 2002 17:23:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265373AbSKNWXo>; Thu, 14 Nov 2002 17:23:44 -0500
Received: from modemcable017.51-203-24.mtl.mc.videotron.ca ([24.203.51.17]:37150
	"EHLO montezuma.mastecende.com") by vger.kernel.org with ESMTP
	id <S265369AbSKNWXn>; Thu, 14 Nov 2002 17:23:43 -0500
Date: Thu, 14 Nov 2002 17:24:11 -0500 (EST)
From: Zwane Mwaikambo <zwane@holomorphy.com>
X-X-Sender: zwane@montezuma.mastecende.com
To: Rusty Russell <rusty@rustcorp.com.au>
cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH][2.5] Remove BUG in cpu_up 
In-Reply-To: <20021114040920.CF9B82C0F7@lists.samba.org>
Message-ID: <Pine.LNX.4.44.0211141721030.2024-100000@montezuma.mastecende.com>
X-Operating-System: Linux 2.4.19-pre5-ac3-zm4
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Nov 2002, Rusty Russell wrote:

> What's wrong with doing it sync?  Are you in a hurry? 8)
> 
> That's what the return code is *for*...
> Rusty.

Yes, i'd rather a box limp along until i can come up with a solution 
rather than it sit there indefinitely waiting for a processor which has 
decided to go on early retirement ;)

But i feel like i'm going round in circles, anyone else with opinions on 
this?

	Zwane
-- 
function.linuxpower.ca

