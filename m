Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261618AbTCYH2q>; Tue, 25 Mar 2003 02:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbTCYH2q>; Tue, 25 Mar 2003 02:28:46 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:11744 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S261618AbTCYH2p>; Tue, 25 Mar 2003 02:28:45 -0500
To: Christoph Hellwig <hch@infradead.org>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v850]  Include <asm/string.h> in v850 simcons.c
References: <20030325025659.307B037CD@mcspd15.ucom.lsi.nec.co.jp>
	<20030325073524.A30897@infradead.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 25 Mar 2003 16:39:47 +0900
In-Reply-To: <20030325073524.A30897@infradead.org>
Message-ID: <buou1drao8s.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:
> Please always use <linux/string.h> instead of the asm variant.

Fear not!  Linus never applies my patches anyway... :-) ... :-(

-Miles
-- 
o The existentialist, not having a pillow, goes everywhere with the book by
  Sullivan, _I am going to spit on your graves_.
