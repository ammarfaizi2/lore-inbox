Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261480AbTCaJUP>; Mon, 31 Mar 2003 04:20:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261495AbTCaJUP>; Mon, 31 Mar 2003 04:20:15 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2052 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S261480AbTCaJUO>; Mon, 31 Mar 2003 04:20:14 -0500
From: John Bradford <john@grabjohn.com>
Message-Id: <200303310930.h2V9U3vQ000202@81-2-122-30.bradfords.org.uk>
Subject: Re: hdparm and removable IDE?
To: house@usq.edu.au (Ron House)
Date: Mon, 31 Mar 2003 10:30:03 +0100 (BST)
Cc: andre@linux-ide.org, davidsen@tmr.com, linux-kernel@vger.kernel.org
In-Reply-To: <3E87C708.2000307@usq.edu.au> from "Ron House" at Mar 31, 2003 02:41:44 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Just one general comment, though. I believe it would be a very big coup 
> for Linux if this feature (hot-swap IDE) were built into Linux properly. 
> These big HDs are getting cheap, and the ability to back-up entire 
> systems, send truly huge image and sound files to colleagues, etc., make 
> this a really high-potential medium. A concrete *feature* like this 
> would really speak to less knowledgeable users than some of the more 
> technical developments, vital though they are.

I agree.

Something that occurs to me - if a machine has non hot-swap capable
IDE hardware, but has suspend to RAM functionality, presumably it is
OK from an electronic viewpoint to swap disks?  What about PCI hot
swap?  Presumably we can remove a non hot-swap IDE controller
completely, and re-install it with different drives connected?

In other words, perhaps IDE hot swap capable equipment is not
completely a pre-requisite to make use of IDE hot swap from the kernel
point of view.

John.
