Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264261AbTKKFlJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 00:41:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264262AbTKKFlJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 00:41:09 -0500
Received: from fw.osdl.org ([65.172.181.6]:35805 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264261AbTKKFlE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 00:41:04 -0500
Date: Mon, 10 Nov 2003 21:40:58 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: bill davidsen <davidsen@tmr.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.9test9-mm1 and DAO ATAPI cd-burning corrupt
In-Reply-To: <boppm8$94h$1@gatekeeper.tmr.com>
Message-ID: <Pine.LNX.4.44.0311102136280.2881-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 11 Nov 2003, bill davidsen wrote:
> Linus Torvalds  <torvalds@osdl.org> wrote:
> | 
> | Feel free to send out patches to be tested.
> | 
> | I'll be waiting for the people out there to test them. But so far I 
> | haven't heard anything but misplaced whining from you.
> 
> You musta' missed the post from the user with the MO that requires
> ide-scsi... And I'm sure you didn't see Alan's post on SATA devices, and
> won't see any other posts in favor of providing the same functionality
> as 2.4. Point closed.

You can't read. Point closed.

NOBODY IS SENDING ME PATCHES. 

What part of "open source" do you not understand? 

SATA devices work fine. They have all the SCSI infrastructure working for
them. They'll "just work", even though I fervently hope that we can move
them over to the block device layer later to make them work more
efficiently.

As per the MO device that wants ide-scsi, send out patches to the kernel
mailing list, and maybe the person can test it. I certainly can't test it.

My point is that YOU ARE BARKING UP THE WRONG TREE. It does not help to 
complain to me - since I don't even have the hardware to test anything 
with. I fixed the IDE CD burning issue. That I had hardware for, and knew 
how to fix properly. 

Now it's your turn. Instead of wasting my time complaining, how about you 
put up or shut up? Show me the code. THEN post it. Until you do, there's 
no point to your mails.

			Linus

