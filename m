Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263462AbTFGTS6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 15:18:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263487AbTFGTS5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 15:18:57 -0400
Received: from zork.zork.net ([64.81.246.102]:10639 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S263462AbTFGTS4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 15:18:56 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: What are .s files in arch/i386/boot
References: <Pine.LNX.4.44.0306072102580.1776-100000@jlap.stev.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Sat, 07 Jun 2003 20:32:30 +0100
In-Reply-To: <Pine.LNX.4.44.0306072102580.1776-100000@jlap.stev.org> (James
 Stevenson's message of "Sat, 7 Jun 2003 21:05:42 +0100 (BST)")
Message-ID: <6un0gty981.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Stevenson <james@stev.org> writes:

>> > > What are .s files in arch/i386/boot, are they c sources of some sort?
>> > > Where can I find the specifications documents they were made from? 
>> > 
>> > There are not c files.
>> > They are assembler files
>> > 
>> > Try running gcc on a c file with the -S option
>> > it will generate the same then you can tweak the
>> > assembler produced to make it faster.
>> > 
>> Where can I find the .c files they were made from,
>> and the spec sheets the .c files were made from? 
>
> You would have to find the original author of the person
> who tweaks the assembler in the .s file chances are the .c
> file is long gone though.

If there were ever C files to begin with.  It's not unheard-of for
people to write assembler code from scratch.

