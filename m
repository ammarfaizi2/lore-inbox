Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263578AbRFFQsK>; Wed, 6 Jun 2001 12:48:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263583AbRFFQsB>; Wed, 6 Jun 2001 12:48:01 -0400
Received: from twinlark.arctic.org ([204.107.140.52]:39698 "HELO
	twinlark.arctic.org") by vger.kernel.org with SMTP
	id <S263578AbRFFQr4>; Wed, 6 Jun 2001 12:47:56 -0400
Date: Wed, 6 Jun 2001 09:47:55 -0700 (PDT)
From: dean gaudet <dean-list-linux-kernel@arctic.org>
To: "Dr S.M. Huen" <smh1008@cus.cam.ac.uk>
cc: Sean Hunter <sean@dev.sportingbet.com>,
        Xavier Bestel <xavier.bestel@free.fr>, <linux-kernel@vger.kernel.org>
Subject: Re: Break 2.4 VM in five easy steps
In-Reply-To: <Pine.SOL.3.96.1010606103559.20297A-100000@draco.cus.cam.ac.uk>
Message-ID: <Pine.LNX.4.33.0106060934310.21294-100000@twinlark.arctic.org>
X-comment: visit http://arctic.org/~dean/legal for information regarding copyright and disclaimer.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jun 2001, Dr S.M. Huen wrote:

> If you can afford 4GB RAM, you certainly can afford 8GB swap.

this is a completely crap argument.

you should study the economics of managing a farm of thousands of machines
some day.

when you do this, you'll also learn to consider the power requirements
(8W+ per 3.5" disk) which you need to bring to each rack, supply backup
UPS/generator power for, and exhaust through your air conditioning for
each of these useless swap disks.

plus you'll also learn to consider the wages for the unlucky person who
has to go around to every box in a farm, open it up, and install another
disk.

plus you'll learn that the time this person spent installing new disks
wasn't spent installing new systems, which means you couldn't bring as
many customers on line this month, which means you may not make revenue
targets.

plus you'll learn that every time you open a box that's been in production
for a while, there's a small, but noticeable, chance that it won't reboot.
so your normal monthly failure rate will go from the 2% range up to the 5%
range.

-dean

