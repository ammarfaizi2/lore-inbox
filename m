Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268781AbUJKLL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268781AbUJKLL7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 07:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUJKLL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 07:11:59 -0400
Received: from hacksaw.org ([66.92.70.107]:4521 "EHLO hacksaw.org")
	by vger.kernel.org with ESMTP id S268781AbUJKLL5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 07:11:57 -0400
Message-Id: <200410111111.i9BBBolv025895@hacksaw.org>
X-Mailer: exmh version 2.7.0 06/18/2004 with nmh-1.0.4
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: udev: what's up with old /dev ? 
In-reply-to: Your message of "Mon, 11 Oct 2004 11:14:56 +0200."
             <047CCB21-1B66-11D9-96AD-000D9352858E@linuxmail.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 11 Oct 2004 07:11:50 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>FC3t2 boots from an "initrd" image that, among other things, mounts a 
>tmpfs over "/dev" and creates "console", "null", "pts" and then 
>proceeds to load "init".

Is that considered good? I like RedHat, but they are well known for doing 
things of dubious taste.

But I just dislike the whole "stopped dead because of the state of the disk" 
thing. I mean, sure, if there large amounts of stuff just missing, it might be 
hard to get anything done, but it sure would be nice if the kernel would try 
really hard to get to a shell so I can figure out what the problem is.

If the initrd gets corrupted, are we just hosed?
-- 
Is qui iacit in hamas marsupiales.
http://www.hacksaw.org -- http://www.privatecircus.com -- KB1FVD


