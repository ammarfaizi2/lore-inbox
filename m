Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136713AbRA1Dr2>; Sat, 27 Jan 2001 22:47:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136714AbRA1DrS>; Sat, 27 Jan 2001 22:47:18 -0500
Received: from hakva-2.student.nlh.no ([128.39.180.186]:29964 "EHLO
	hakva-2.student.nlh.no") by vger.kernel.org with ESMTP
	id <S136713AbRA1DrG>; Sat, 27 Jan 2001 22:47:06 -0500
To: torvalds@transmeta.com (Linus Torvalds)
Cc: linux-kernel@vger.kernel.org
Subject: Re: ps hang in 241-pre10
In-Reply-To: <3A724FD2.3DEB44C@reptechnic.com.au> <3A7295F6.621BBEC4@Home.com> <3A731E65.8BE87D73@pobox.com> <3A7359BB.7BBEE42A@linux.com> <94voof$17j$1@penguin.transmeta.com>
From: "Håvard Kvålen" <havardk@sol.no>
Date: 28 Jan 2001 04:46:44 +0100
In-Reply-To: <fa.ikhc52v.e68327@ifi.uio.no>
Message-ID: <m33de4fie3.fsf@hakva-2.student.nlh.no>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does anybody have a clue about what is different with xmms?
> 
> Does it use KNI if it can, for example? We used to have a problem
> with KNI+Athlons, for example.

No, it doesn't.

> It might also be that it's threading-related, and that XMMS is one
> of the few things that uses threads. Things like that. I'm not an
> XMMS user, can somebody who knows XMMS comment on things that it
> does that are unusual?

Yes, threads could be the thing that makes a difference.  I can't
think of anything else that is special about XMMS. 

-- 
Håvard Kvålen
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
