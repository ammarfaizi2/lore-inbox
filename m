Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132623AbQKSQer>; Sun, 19 Nov 2000 11:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132624AbQKSQe1>; Sun, 19 Nov 2000 11:34:27 -0500
Received: from magrathea.systime-solutions.de ([212.66.133.138]:65041 "HELO
	magrathea.systime-solutions.de") by vger.kernel.org with SMTP
	id <S132623AbQKSQeW>; Sun, 19 Nov 2000 11:34:22 -0500
Message-ID: <3A180898.EB386DB8@evision-ventures.com>
Date: Sun, 19 Nov 2000 18:06:32 +0100
From: dalecki <dalecki@evision-ventures.com>
Reply-To: dalecki@evision-ventures.com
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Miquel van Smoorenburg <miquels@cistron.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] megaraid driver update for 2.4.0-test10
In-Reply-To: <3A170A06.934405FC@evision-ventures.com> <8v7bm0$hm5$1@enterprise.cistron.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Miquel van Smoorenburg wrote:
> 
> In article <3A170A06.934405FC@evision-ventures.com>,
> dalecki  <dalecki@evision-ventures.com> wrote:
> >This is a multi-part message in MIME format.
> >1. Merge the most current version (aka: 1.08) of the
> >   MegaRAID driver from AMI in to the most current kernel
> >   (2.4.0-test10 and friends).
> 
> The latest is 1.11a or something. The 1.08 one has *bugs*.
> At least if it's the same from the 2.2.18preX series. And even
> that one has still patches outstanding because it doesn't work

No it's not taken from 2.2.18. It's based on the latest stuff found 
on www.ami.com. And then I have fixed some issues which where 
directly obvious. And then it's not quite broken since it's  working
quite fine on the box found here. Anyway. There is some point
where one has to start at ;-).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
