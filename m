Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129068AbRBJXwB>; Sat, 10 Feb 2001 18:52:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130340AbRBJXvw>; Sat, 10 Feb 2001 18:51:52 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:23816 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S129068AbRBJXvg>;
	Sat, 10 Feb 2001 18:51:36 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200102102351.f1ANpTw457945@saturn.cs.uml.edu>
Subject: Re: spelling of disc (disk) in /devfs
To: kernel@blackhole.compendium-tech.com (Dr. Kelsey Hudson)
Date: Sat, 10 Feb 2001 18:51:29 -0500 (EST)
Cc: alan@chandlerfamily.org.uk (Alan Chandler), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0102091639400.26669-100000@sol.compendium-tech.com> from "Dr. Kelsey Hudson" at Feb 09, 2001 04:41:39 PM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It had always been my assumption that non-optical storage media used
> the 'disk' spelling, whereas optical media, such as CDs, DVDs, and MO,
> were reffered to using the 'disc' spelling.

No, "disk" is correct for everything, but we use "disc" for a reason.

It is a non-word, which helps with trademark protection.
It is odd, so it catches attention. Companies operating
in the US have a habit of spelling words wrong whenever
possible.

To us, "disc" is like "cliq", "qwest", "thru", "raq"...

Real UNIX uses "dsk", but IBM's name ("dasd") makes more sense
for all the recent non-disk storage devices. The shape of the
device does not matter; what matters is that it is a Direct
Access Storage Device.

Using "disc" just sucks. I think the devfs author likes to
make the rest of the world suffer for some nationalistic
revenge. I and many others will forever curse the damn thing.


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
