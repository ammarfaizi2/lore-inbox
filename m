Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262009AbREPRCf>; Wed, 16 May 2001 13:02:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262010AbREPRCP>; Wed, 16 May 2001 13:02:15 -0400
Received: from 216.41.5.host170 ([216.41.5.170]:12138 "EHLO
	habitrail.home.fools-errant.com") by vger.kernel.org with ESMTP
	id <S262009AbREPRCO>; Wed, 16 May 2001 13:02:14 -0400
Message-Id: <200105161702.f4GH2Cu05908@habitrail.home.fools-errant.com>
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.3
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: LANANA: To Pending Device Number Registrants 
In-Reply-To: Your message of "Tue, 15 May 2001 19:00:12 +0200."
             <3B01609C.CD9EBFF4@uni-mb.si> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 16 May 2001 13:02:12 -0400
From: Hacksaw <hacksaw@hacksaw.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>So what is your solution for preventing a boot failure after disks/partitions
>change ?
>volume labels/UUID ?

As a sys-admin, let me add a vote for this. Having (one day) a prom monitor 
program that looks at all the disks, and gives a menu of which one to boot 
from would make life so nice.

I very often had to move disks from one platform to another, and changing ID's 
on the was hard or impossible in some cases, and required in others. Being 
able to find the disk by a label is a thousand times better.



