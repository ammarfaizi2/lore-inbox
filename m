Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268332AbRGWTKj>; Mon, 23 Jul 2001 15:10:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268331AbRGWTK3>; Mon, 23 Jul 2001 15:10:29 -0400
Received: from mnh-1-25.mv.com ([207.22.10.57]:5130 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S268332AbRGWTKT>;
	Mon, 23 Jul 2001 15:10:19 -0400
Message-Id: <200107232025.PAA03490@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrea Arcangeli <andrea@suse.de>
cc: Linus Torvalds <torvalds@transmeta.com>,
        user-mode-linux-user@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: user-mode port 0.44-2.4.7 
In-Reply-To: Your message of "Mon, 23 Jul 2001 17:56:35 +0200."
             <20010723175635.L822@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 23 Jul 2001 15:25:27 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

andrea@suse.de said:
> in my tree I did some further cleanup, here the ones that you can
> interested about: 

Thanks, it's in my queue.

Although I think I'll hold off on the xtime change until you and Linus have 
decided whether it needs volatile or locking :-)

				Jeff

