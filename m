Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267184AbRG3TTe>; Mon, 30 Jul 2001 15:19:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267018AbRG3TTY>; Mon, 30 Jul 2001 15:19:24 -0400
Received: from saturn.cs.uml.edu ([129.63.8.2]:48398 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S267184AbRG3TTN>;
	Mon, 30 Jul 2001 15:19:13 -0400
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200107301919.f6UJJH7227019@saturn.cs.uml.edu>
Subject: Re: Test mail
To: torrey.hoffman@myrio.com (Torrey Hoffman)
Date: Mon, 30 Jul 2001 15:19:17 -0400 (EDT)
Cc: acahalan@cs.uml.edu ('Albert D. Cahalan'), ignacio@openservices.net,
        linux-kernel@vger.kernel.org
In-Reply-To: <D52B19A7284D32459CF20D579C4B0C0211C971@mail0.myrio.com> from "Torrey Hoffman" at Jul 30, 2001 11:32:05 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Torrey Hoffman writes:

> I hate to jump in and extend this mostly off-topic thread, but I would be
> a little annoyed if Outlook was banned from LKML.  I've got two machines
> on my desk here at work - one is Win2K, and is used almost exclusively for 
> Outlook and Word.  It's very difficult to give those up when the rest of
> the company uses them extensively.  The automatic meeting scheduling and
> other MS Exchange features of Outlook are not available in other clients, 
> and why should I switch when Outlook works fine?  
>
> Of course the other computer runs Linux, and is where all my real work
> gets done.  It's convenient to have both environments.

This does not mean you have to use Outlook to _send_ mail to
the linux-kernel mailing list. Do this:

1. log into the Linux box you have
2. run emacs
3. Control-x m
4. fill in the header fields and write your message
5. Control-c Control-c

If you really must send mail directly from the Windows box,
get emacs for Windows and skip step 1 above.

BTW, if you can't log into anything that can open an SMTP connection
to the outside world and don't have a relay, then most likely your
employer doesn't want you sending stuff to linux-kernel anyway.
