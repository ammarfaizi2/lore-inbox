Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269796AbRHQHij>; Fri, 17 Aug 2001 03:38:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269804AbRHQHia>; Fri, 17 Aug 2001 03:38:30 -0400
Received: from haneman.dialup.fu-berlin.de ([160.45.224.9]:50816 "EHLO
	haneman.dialup.fu-berlin.de") by vger.kernel.org with ESMTP
	id <S269796AbRHQHiR>; Fri, 17 Aug 2001 03:38:17 -0400
Content-Type: text/plain; charset=US-ASCII
From: Enver Haase <ehaase@inf.fu-berlin.de>
Organization: FU Berlin
To: linux-kernel@vger.kernel.org
Subject: ext2 not NULLing deleted files?
Date: Fri, 17 Aug 2001 09:38:10 +0200
X-Mailer: KMail [version 1.2]
MIME-Version: 1.0
Message-Id: <01081709381000.08800@haneman>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi there,

I just recognized there's an "undelete" now for ext2 file systems [a KDE 
app].

"The Other OS" in its professional version does of course clear the deleted 
blocks with 0's for security reasons; I would have bet a thousand bucks Linux 
would do so, too [seems I should have read the source code, good thing no-one 
wanted to take on the bet :) ].

So how to go about this? With that feature wanted, which fs should one choose 
under Linux? Is there a patch for ext2 for that feature? Am I the only one 
liking the idea?

Greetings,
Enver
