Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271878AbRIIEZW>; Sun, 9 Sep 2001 00:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271880AbRIIEZM>; Sun, 9 Sep 2001 00:25:12 -0400
Received: from mnh-1-05.mv.com ([207.22.10.37]:28679 "EHLO ccure.karaya.com")
	by vger.kernel.org with ESMTP id <S271878AbRIIEZD>;
	Sun, 9 Sep 2001 00:25:03 -0400
Message-Id: <200109090542.AAA03940@ccure.karaya.com>
X-Mailer: exmh version 2.0.2
To: Andrea Arcangeli <andrea@suse.de>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: expand_stack fix [was Re: 2.4.9aa3] 
In-Reply-To: Your message of "Sun, 09 Sep 2001 05:50:38 +0200."
             <20010909055038.M11329@athlon.random> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 09 Sep 2001 00:42:03 -0500
From: Jeff Dike <jdike@karaya.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

andrea@suse.de said:
> ok, so I guess you're doing the growsdown by hand in the uml sigsegv
> handler. 

Right, exactly the same way that every other port does it.

				Jeff

