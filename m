Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbTI1DF2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 23:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbTI1DF2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 23:05:28 -0400
Received: from codepoet.org ([166.70.99.138]:55434 "EHLO mail.codepoet.org")
	by vger.kernel.org with ESMTP id S262310AbTI1DFZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 23:05:25 -0400
Date: Sat, 27 Sep 2003 21:05:26 -0600
From: Erik Andersen <andersen@codepoet.org>
To: David Ford <david+powerix@blue-labs.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: LInksys WMP11 (BCM4301 chip)
Message-ID: <20030928030526.GA25032@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	David Ford <david+powerix@blue-labs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <3F761515.4020609@blue-labs.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F761515.4020609@blue-labs.org>
X-Operating-System: Linux 2.4.19-rmk7, Rebel-NetWinder(Intel StrongARM 110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat Sep 27, 2003 at 06:54:13PM -0400, David Ford wrote:
> According to http://www.linuxworld.com/story/33804.htm, (Andrew Miklas), 
> the BCM4301 is supported however I don't see any such critter in my source.

This is a _terribly_ misleading article.  There are only a few
little bits of truth in the article you have referenced, and even
that has been spun to exagerate the truth.

Broadcom has never released the source for the referenced chips
to the general public.  Those are closed source, binary-only,
mipsel drivers for kernel 2.4.5 that are embedded within the
device firmware. 

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
