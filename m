Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131582AbQL3EwS>; Fri, 29 Dec 2000 23:52:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131768AbQL3Evy>; Fri, 29 Dec 2000 23:51:54 -0500
Received: from box-154.rosh.inter.net.il ([213.8.204.154]:53257 "EHLO
	callisto.yi.org") by vger.kernel.org with ESMTP id <S131055AbQL3Evu>;
	Fri, 29 Dec 2000 23:51:50 -0500
Date: Sat, 30 Dec 2000 06:21:01 +0200 (IST)
From: Dan Aloni <karrde@callisto.yi.org>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Alexander Viro <aviro@redhat.com>,
        "Stephen C. Tweedie" <sct@redhat.com>, "Marco d'Itri" <md@Linux.IT>,
        Jeff Lightfoot <jeffml@pobox.com>,
        Anton Blanchard <anton@linuxcare.com.au>
Subject: Re: test13-pre6
In-Reply-To: <Pine.LNX.4.10.10012291609470.1123-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0012300617360.826-100000@callisto.yi.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 29 Dec 2000, Linus Torvalds wrote:

> Marco d'Itri and everybody else who has seen innd problems (or other
> shared map problems): can you verify that test13-pre6 works for you?

The ->mapping problem seems to be gone in test13-pre5, I'm running this
kernel for over 30 hours now with no glitch, gonna check if it's the same
for test13-pre6.

-- 
Dan Aloni 
dax@karrde.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
