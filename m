Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264770AbSJWMGE>; Wed, 23 Oct 2002 08:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264872AbSJWMGE>; Wed, 23 Oct 2002 08:06:04 -0400
Received: from 62-190-201-217.pdu.pipex.net ([62.190.201.217]:1284 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S264770AbSJWMGD>; Wed, 23 Oct 2002 08:06:03 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210231221.g9NCLehF003955@darkstar.example.net>
Subject: Re: 2.5 Problem Report Status
To: tmolina@cox.net (Thomas Molina)
Date: Wed, 23 Oct 2002 13:21:40 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210222038380.8594-100000@dad.molina> from "Thomas Molina" at Oct 22, 2002 09:07:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>                                2.5 Kernel Problem Reports as of 22 Oct
>    Status                 Discussion  Problem Title

> --------------------------------------------------------------------------
>    open                   05 Oct 2002 2.5.x and 8250 UART problems
>   21. http://marc.theaimsgroup.com/?l=linux-kernel&m=103383019409525&w=2
> 
> --------------------------------------------------------------------------

Tried 2.5.44 with preemption disabled, (it has been enabled for all
2.5.x up to now), and the problem is still there.  Infact, it seems
worse - ZModem transfers are going down to 512 block size, because of
the errors :-(

> --------------------------------------------------------------------------
>    open                   17 Oct 2002 IDE not powered down on shutdown
>   55. http://marc.theaimsgroup.com/?l=linux-kernel&m=103476420012508&w=2
> 
> --------------------------------------------------------------------------

Still happens with 2.5.44

John.
