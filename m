Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130653AbQLRXjY>; Mon, 18 Dec 2000 18:39:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129595AbQLRXjE>; Mon, 18 Dec 2000 18:39:04 -0500
Received: from ns-inetext.inet.com ([199.171.211.140]:51919 "EHLO
	ns-inetext.inet.com") by vger.kernel.org with ESMTP
	id <S129391AbQLRXiz>; Mon, 18 Dec 2000 18:38:55 -0500
Message-ID: <3A3E98E9.F68BC13A@inet.com>
Date: Mon, 18 Dec 2000 17:08:25 -0600
From: Eli Carter <eli.carter@inet.com>
Organization: Inet Technologies, Inc.
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.5-15 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: generic sleeping locks?
In-Reply-To: <E1489Hp-0006Ms-00@the-village.bc.nu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> 
> > Are there blocking lock primitives already defined somewhere in the
> > kernel?
> 
> down and up are normally appropriate for this

Ungh.  Forest.  Trees.  *sigh*  Sorry for the dumb question.  
Thanks for the reply Alan.  :)

Ok, second part of the question:  What about blocking read/write locks
(with _interruptible variants)?

TIA,

Eli
--------------------. "To the systems programmer, users and applications
Eli Carter          | serve only to provide a test load."
eli.carter@inet.com `---------------------------------- (random fortune)
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
