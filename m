Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319233AbSIFRKs>; Fri, 6 Sep 2002 13:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319258AbSIFRKs>; Fri, 6 Sep 2002 13:10:48 -0400
Received: from 62-190-218-30.pdu.pipex.net ([62.190.218.30]:45316 "EHLO
	darkstar.example.net") by vger.kernel.org with ESMTP
	id <S319233AbSIFRKr>; Fri, 6 Sep 2002 13:10:47 -0400
From: jbradford@dial.pipex.com
Message-Id: <200209061722.g86HMuPp004452@darkstar.example.net>
Subject: Re: ide drive dying?
To: devilkin-lkml@blindguardian.org (DevilKin)
Date: Fri, 6 Sep 2002 18:22:55 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200209061755.06344.devilkin-lkml@blindguardian.org> from "DevilKin" at Sep 06, 2002 05:55:06 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, I downloaded that and installed it, but well, frankly, it shows me very 
> little useful stuff.
> 
> Or i'm just not good at interpreting this.

Post the output of smartctl -a /dev/hda? to me, and I'll tell you what I can, but it's best to monitor the stats from when the drive is new, (I.E. every drive you buy from now on :-) ).

John.
