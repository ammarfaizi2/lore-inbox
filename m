Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263544AbSJWJjy>; Wed, 23 Oct 2002 05:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264611AbSJWJjf>; Wed, 23 Oct 2002 05:39:35 -0400
Received: from 62-190-219-22.pdu.pipex.net ([62.190.219.22]:20487 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263544AbSJWJhz>; Wed, 23 Oct 2002 05:37:55 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210230953.g9N9rVIL000743@darkstar.example.net>
Subject: Re: 2.5 Problem Report Status
To: tmolina@cox.net (Thomas Molina)
Date: Wed, 23 Oct 2002 10:53:31 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina> from "Thomas Molina" at Oct 22, 2002 09:07:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Following is the latest version of my status report web page.  It can be 
> found at:
> 
> http://members.cox.net/tmolina/kernprobs/status.html
> 
> I've seen a lot of positive feedback for Martin's proposal to create a 
> bugzilla for kernel bug reports so this is likely to be my last formal 
> posting on this subject.  I intend to enter these as the "seed" bug 
> reports for his effort, so any comment on this is welcome.  

> --------------------------------------------------------------------------
>    open                   17 Oct 2002 IDE not powered down on shutdown
>   55. http://marc.theaimsgroup.com/?l=linux-kernel&m=103476420012508&w=2
> 
> --------------------------------------------------------------------------

This doesn't happen on every shutdown, but randomly on about 30% of
shutdowns.  Only observed with 2.5.43.  Has somebody changed the order
of the flush and spindown commands to the IDE devices?

I will try 2.5.44 on the machine later today, and report
success/failiure.

John.
