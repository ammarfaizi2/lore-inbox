Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293204AbSCJTyZ>; Sun, 10 Mar 2002 14:54:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293205AbSCJTyP>; Sun, 10 Mar 2002 14:54:15 -0500
Received: from stargazer.compendium-tech.com ([64.156.208.76]:62398 "EHLO
	stargazer.compendium-tech.com") by vger.kernel.org with ESMTP
	id <S293204AbSCJTyD>; Sun, 10 Mar 2002 14:54:03 -0500
Date: Sun, 10 Mar 2002 11:53:54 -0800 (PST)
From: Kelsey Hudson <khudson@compendium-tech.com>
To: Jeffrey Siegal <jbs@quiotix.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: Recommended dual Xeon motherboard for 2.4?
In-Reply-To: <3C8AEED1.80104@quiotix.com>
Message-ID: <Pine.LNX.4.44.0203101147470.20626-100000@sol.compendium-tech.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anyone have one of these running reliably?  I've seen a lot of 
> messages about hard lockups, BIOS bugs, and such.
> 
> I'm looking for an off-the-shelf MB that will work reliably with the new 
> Prestonia CPUs.

Off the shelf, I've had relatively few problems with my Supermicro P6DCE+. 
Aside from not supporting higher than 12 physical IDE devices (6 masters), 
being mostly ACPI-driven, requiring some odd-ball 24-pin+8-pin+4-pin 
power supply, and having a terrible board layout, I'm very 
impressed with this motherboard and its features. I haven't experienced a 
single lockup with the board, and it's been running in production using 
2.4.19-pre2-ac2 now for 3 days without a hitch. Hyperthreading is enabled. 
It's a dual 2.0GHz machine, and easily the fastest PC-based machine I've 
ever used. It's got its quirks, which you'll see in practice, but aside 
from them, i'd highly reccommend this motherboard.

hope this helps...

 Kelsey Hudson                                           khudson@ctica.com 
 Associate Software Engineer
 Compendium Technologies, Inc                               (619) 725-0771
---------------------------------------------------------------------------     
==== 0100101101001001010000110100101100100000010010010101010000100001 =====


