Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264312AbTFHCiu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 7 Jun 2003 22:38:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264398AbTFHCiu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 7 Jun 2003 22:38:50 -0400
Received: from dsl092-013-071.sfo1.dsl.speakeasy.net ([66.92.13.71]:10387 "EHLO
	pelerin.serpentine.com") by vger.kernel.org with ESMTP
	id S264312AbTFHCit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 7 Jun 2003 22:38:49 -0400
Subject: Re: memtest86 on the opteron
From: "Bryan O'Sullivan" <bos@serpentine.com>
To: Pavel Machek <pavel@suse.cz>
Cc: dan carpenter <error27@email.com>, chris@memtest86.com,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030607214356.GF667@elf.ucw.cz>
References: <20030607202725.22992.qmail@email.com>
	 <20030607214356.GF667@elf.ucw.cz>
Content-Type: text/plain
Organization: 
Message-Id: <1055040745.27939.3.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 07 Jun 2003 19:52:25 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-06-07 at 14:43, Pavel Machek wrote:

> Well, as opteron is i386-compatible, you should be able to simply use
> i386 memtest...

It doesn't work.  Crashes and reboots the system shortly after it
starts.  The serial console support appears to have bit-rotted, too, so
I've not been able to capture an output screen to diagnose the problem.

	<b

