Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280988AbRKOSl5>; Thu, 15 Nov 2001 13:41:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280989AbRKOSlj>; Thu, 15 Nov 2001 13:41:39 -0500
Received: from 24-163-106-43.he2.cox.rr.com ([24.163.106.43]:2450 "EHLO
	asd.ppp0.com") by vger.kernel.org with ESMTP id <S280988AbRKOSlO>;
	Thu, 15 Nov 2001 13:41:14 -0500
Date: Thu, 15 Nov 2001 13:41:16 -0500
Subject: Re: Constant oops when PnP OS set to 'Y' in BIOS
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v472)
Cc: linux-kernel@vger.kernel.org
To: Mark Cave-Ayland <mca198@ecs.soton.ac.uk>
From: Anthony DeRobertis <asd@suespammers.org>
In-Reply-To: <Pine.LNX.4.21.0111151531590.7211-101000@ugnode3.ecs.soton.ac.uk>
Message-Id: <5A1E3968-D9F8-11D5-AAC3-00039355CFA6@suespammers.org>
Content-Transfer-Encoding: 7bit
X-Mailer: Apple Mail (2.472)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thursday, November 15, 2001, at 10:39 , Mark Cave-Ayland wrote:

> Incidentally whilst compiling the 2.4.13 kernel to test, with 
> PnP set to
> 'No', I encountered many segment faults which required me to 
> restart gcc

Run memtest86. That sounds like bad memory.

Also, some Gigabyte boards in my experience have been extremely 
unhappy when the multiple DIMMs on the board are not identical.

