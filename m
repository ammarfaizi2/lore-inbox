Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286893AbSA1WCg>; Mon, 28 Jan 2002 17:02:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286895AbSA1WC0>; Mon, 28 Jan 2002 17:02:26 -0500
Received: from [217.9.226.246] ([217.9.226.246]:25985 "HELO
	merlin.xternal.fadata.bg") by vger.kernel.org with SMTP
	id <S286893AbSA1WCP>; Mon, 28 Jan 2002 17:02:15 -0500
To: Daniel Phillips <phillips@bonn-fries.net>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Rik van Riel <riel@conectiva.com.br>,
        Josh MacDonald <jmacd@CS.Berkeley.EDU>, <linux-kernel@vger.kernel.org>,
        <reiserfs-list@namesys.com>, <reiserfs-dev@namesys.com>
Subject: Re: Note describing poor dcache utilization under high memory pressure
In-Reply-To: <Pine.LNX.4.33.0201281005480.1609-100000@penguin.transmeta.com>
	<E16VHy5-0000Bz-00@starship.berlin>
From: Momchil Velikov <velco@fadata.bg>
In-Reply-To: <E16VHy5-0000Bz-00@starship.berlin>
Date: 29 Jan 2002 00:01:37 +0200
Message-ID: <87u1t6f83i.fsf@fadata.bg>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Daniel" == Daniel Phillips <phillips@bonn-fries.net> writes:

Daniel> I'd cheerfully hand this coding effort off to someone more familiar with this 
Daniel> particular neck of the kernel woods - you, Davem and Marcelo come to mind, 
Daniel> but if nobody bites I'll just continue working on it at my own pace.  I 

BTW, I'm doing just this, working on it at my own pace. 
