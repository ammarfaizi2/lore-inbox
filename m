Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279067AbRJ2IAx>; Mon, 29 Oct 2001 03:00:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279069AbRJ2IAm>; Mon, 29 Oct 2001 03:00:42 -0500
Received: from f05s15.cac.psu.edu ([128.118.141.58]:32762 "EHLO
	f05n15.cac.psu.edu") by vger.kernel.org with ESMTP
	id <S279067AbRJ2IA1>; Mon, 29 Oct 2001 03:00:27 -0500
Message-ID: <3BDD0D0E.6000609@stones.com>
Date: Mon, 29 Oct 2001 03:02:22 -0500
From: Justin Mierta <Crazed_Cowboy@stones.com>
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:0.9.5) Gecko/20011011
X-Accept-Language: en-us
MIME-Version: 1.0
CC: linux-kernel@vger.kernel.org, hahn@physics.mcmaster.ca,
        alan@lxorguk.ukuu.org.uk, lung@theuw.net
Subject: Re: ECS k7s5a motherboard doesnt work
In-Reply-To: <E15xzhf-0000tl-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

here's some more info for everyone trying to help:
redhat says (at some point) that it insmod'd sis900, not the sis5513 
that mark had suggested, and the sis735 that everything says is actually 
in the motherboard.  (i have to assume the sis900 was ide, because it 
didnt tell me anything more useful than "insmod sis900" and that it worked)

however, the messages i'm seeing are something like this:
hda atapi: reset complete
irq timeout: complete status = 0xC0   { busy }       (sometimes thats 0xD0)

then there's a few lines every now and then saying "drive not ready for 
command" and "I/O error"

any suggestions?

justin


