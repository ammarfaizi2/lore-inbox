Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264918AbRFZMzZ>; Tue, 26 Jun 2001 08:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264916AbRFZMzP>; Tue, 26 Jun 2001 08:55:15 -0400
Received: from m169-mp1-cvx1a.col.ntl.com ([213.104.68.169]:60544 "EHLO
	[213.104.68.169]") by vger.kernel.org with ESMTP id <S264913AbRFZMzI>;
	Tue, 26 Jun 2001 08:55:08 -0400
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>
Subject: Re: VM tuning through fault trace gathering [with actual code]
In-Reply-To: <Pine.LNX.4.21.0106252152580.941-100000@freak.distro.conectiva>
From: John Fremlin <vii@users.sourceforge.net>
Date: 26 Jun 2001 13:54:30 +0100
In-Reply-To: <Pine.LNX.4.21.0106252152580.941-100000@freak.distro.conectiva> (Marcelo Tosatti's message of "Mon, 25 Jun 2001 21:53:33 -0300 (BRT)")
Message-ID: <m2n16vcsft.fsf@boreas.yi.org.>
User-Agent: Gnus/5.090004 (Oort Gnus v0.04) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> writes:

> On 25 Jun 2001, John Fremlin wrote:
> 
> > 
> > Last year I had the idea of tracing the memory accesses of the system
> > to improve the VM - the traces could be used to test algorithms in
> > userspace. The difficulty is of course making all memory accesses
> > fault without destroying system performance.

[...]

> Linux Trace Toolkit (http://www.opersys.com/LTT) does that. 

I dld the ltt-usenix paper and skim read it. It didn't seem to talk
about page faults much. Where should I look?

-- 

	http://ape.n3.net
