Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbUCBPYp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbUCBPYp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:24:45 -0500
Received: from asteroids.scarlet-internet.nl ([213.204.195.163]:3469 "EHLO
	asteroids.scarlet-internet.nl") by vger.kernel.org with ESMTP
	id S261670AbUCBPYo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:24:44 -0500
Message-ID: <1078241080.4044a7382010b@webmail.dds.nl>
Date: Tue,  2 Mar 2004 16:24:40 +0100
From: wdebruij@dds.nl
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: kernel reference resource thread. Share your links svp
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
User-Agent: Internet Messaging Program (IMP) 3.2.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There's a lot of information available online about the linux kernel and kernel
hacking. Having done some hacking myself I managed to find quite a few useful,
but relatively hidden resources. Perhaps these are of interest to others as well.
My links - having to do mostly with modules, networking and v2.4/v2.6 porting -
can be found at 

http://ffpf.sf.net/#kernelres

Since everyone on this list is doing something related to kernel hacking, my
question to you is... do you know of some other hidden treasures? Please post
follow-ups if you do, this might save others some valuable time (I know it took
me ages to find some of these documents).

On a related note.. I've also implemented some standard tasks, such as module
loading/unloading, mmap handling and /dev file usage in generalized files for
others to use and abuse (or just read as examples). These can also be found on
the previously mentioned webpage. All files are v2.4/v2.6 portable and some are
both userspace/kernelspace compatible.

Finally, a small disclaimer: I know this post doesn't cover a very detailed
hacking topic, but I don't know of a better list to discuss these more long-term
goals than the LKML. Correct me if I'm wrong :)

Willem



