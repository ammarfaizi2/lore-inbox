Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132797AbRDDLHx>; Wed, 4 Apr 2001 07:07:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132796AbRDDLHn>; Wed, 4 Apr 2001 07:07:43 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:9997 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132795AbRDDLH3>; Wed, 4 Apr 2001 07:07:29 -0400
Subject: Re: 2.4.3 : Are all 2.4.2-acXX patches included?
To: puckwork@madz.net (Thomas Foerster)
Date: Wed, 4 Apr 2001 12:09:07 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20010404071851Z132758-406+7477@vger.kernel.org> from "Thomas Foerster" at Apr 04, 2001 09:17:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kl9y-0001iY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> i wonder if every ac-XX patch from the 2.4.2 Kernel is included in the new
> 2.4.3 kernel so that every bug in 2.4.2 has been fixed in 2.4.3 ?

about 30% by volume of 2.4.2ac is in 2.4.3. 2.4.3ac1 will give you the
2.4.2ac tree versus 2.4.3 and its about an 8Mb diff. That represents a mix
of stuff Linus apparently didnt want yet (eg the fixes for file size limits)
stuff I don't think is ready and stuff that I didnt send because Linus said
2.4.3pre was already 'too big'

Alan


