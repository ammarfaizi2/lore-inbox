Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130235AbQJaEjM>; Mon, 30 Oct 2000 23:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130214AbQJaEjD>; Mon, 30 Oct 2000 23:39:03 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:23303 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S130263AbQJaEir>;
	Mon, 30 Oct 2000 23:38:47 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200010310438.e9V4cOD299876@saturn.cs.uml.edu>
Subject: Re: [PATCH] ipv4 skbuff locking scope
To: davem@redhat.com (David S. Miller)
Date: Mon, 30 Oct 2000 23:38:24 -0500 (EST)
Cc: tleete@mountain.net, linux-kernel@vger.kernel.org, netdev@oss.sgi.com
In-Reply-To: <200010302224.OAA02266@pizda.ninka.net> from "David S. Miller" at Oct 30, 2000 02:24:46 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller writes:

> BTW, while we're on the topic of people not understanding the
> networking locking and proposing bogus patches, does anyone know who
> sent the bogon IP tunneling locking "fixes" to Linus behind my back?
...
> Please send such fixes to me, and I'll set you straight with a
> description as to why your change is unnecessary :-)

You can prevent future "fixes" by putting your comments in the code.

/*  like this  */
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
