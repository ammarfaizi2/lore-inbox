Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264172AbRFFVg6>; Wed, 6 Jun 2001 17:36:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264173AbRFFVgs>; Wed, 6 Jun 2001 17:36:48 -0400
Received: from asteria.host4u.net ([216.71.64.118]:59922 "EHLO
	asteria.host4u.net") by vger.kernel.org with ESMTP
	id <S264172AbRFFVgf>; Wed, 6 Jun 2001 17:36:35 -0400
Message-Id: <5.1.0.14.2.20010606143453.028ed400@ansa.hostings.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 06 Jun 2001 14:39:50 -0700
To: torvalds@transmeta.com (Linus Torvalds)
From: android <linux@ansa.hostings.com>
Subject: Re: Break 2.4 VM in five easy steps
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9fm4t7$412$1@penguin.transmeta.com>
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Is anybody interested in making "swapoff()" better? Please speak up..
>
>                 Linus

I'd be happy to write a new routine in assembly, if I had a clue as to how
the VM algorithm works in Linux. What should swapoff  do if all physical
memory is in use? How does the swapping algorithm balance against
cache memory? Can someone point me to where I can find the exact
details of the VM mechanism in Linux? Thanks!

                       -- Ted

