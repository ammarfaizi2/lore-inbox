Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266456AbTAOOO0>; Wed, 15 Jan 2003 09:14:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266473AbTAOOOG>; Wed, 15 Jan 2003 09:14:06 -0500
Received: from khms.westfalen.de ([62.153.201.243]:42930 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S266456AbTAOOMs>; Wed, 15 Jan 2003 09:12:48 -0500
Date: 14 Jan 2003 21:53:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <8dqipJL1w-B@khms.westfalen.de>
In-Reply-To: <20030112204005$7287@gated-at.bofh.it>
Subject: Re: any chance of 2.6.0-test*?
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20030112201009$1534@gated-at.bofh.it> <20030112204005$7287@gated-at.bofh.it>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

torvalds@transmeta.com (Linus Torvalds)  wrote on 12.01.03 in <20030112204005$7287@gated-at.bofh.it>:

> No, you've been brainwashed by CS people who thought that Niklaus Wirth
> actually knew what he was talking about. He didn't. He doesn't have a
> frigging clue.

Well ... he did have some nice ideas. Unfortunately, they usually don't  
get palatable until someone else has worked on them.

If you look into Wirth's books and see that the example code in there ...

* uses one(!) space indentation
* routinely puts several statements on one line
* typically uses one- or two-character variable names

... then you realize that *every* Wirth source needs rewriting.

---
Niklaus Wirth has lamented that, whereas Europeans pronounce his name correctly
(Ni-klows Virt), Americans invariably mangle it into (Nick-les Worth).  Which
is to say that Europeans call him by name, but Americans call him by value.
---
#if _FP_W_TYPE_SIZE < 32
#error "Here's a nickle kid.  Go buy yourself a real computer."
#endif
	-- linux/arch/sparc64/double.h
---

MfG Kai
