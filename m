Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263202AbSJCIXP>; Thu, 3 Oct 2002 04:23:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263204AbSJCIXO>; Thu, 3 Oct 2002 04:23:14 -0400
Received: from 62-190-219-97.pdu.pipex.net ([62.190.219.97]:56836 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S263202AbSJCIXO>; Thu, 3 Oct 2002 04:23:14 -0400
From: jbradford@dial.pipex.com
Message-Id: <200210030836.g938a54o001105@darkstar.example.net>
Subject: Re: 2.5.40: AT keyboard input problem
To: tori@ringstrom.mine.nu (Tobias Ringstrom)
Date: Thu, 3 Oct 2002 09:36:05 +0100 (BST)
Cc: vojtech@suse.cz, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.44.0210030846180.11746-100000@boris.prodako.se> from "Tobias Ringstrom" at Oct 03, 2002 08:59:30 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> While 2.5 has worked better than I hoped for so far, I do have a problem 
> with the new input layer (I think) that is easily reproducible, and quite 
> irritating.
> 
> If I press and hold my left Alt key, press and release the right AltGr
> key, and then release the left Alt key, I get one of the following
> messages in dmesg:

[snip]

> The same thing happens for a few other combinations as well. I happens 
> both in X and in the console.

I am getting similar odd behavior with 2.5.40 and a Japanese keyboard.  Specifically, if I bang away at repeatedly on 't', 'h', '@', and ';', I get unknown key messages in dmesg.

I posted about this a while ago, but I don't think anybody noticed :-)

John.
