Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269021AbRHGQYb>; Tue, 7 Aug 2001 12:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269007AbRHGQYV>; Tue, 7 Aug 2001 12:24:21 -0400
Received: from [63.209.4.196] ([63.209.4.196]:9744 "EHLO neon-gw.transmeta.com")
	by vger.kernel.org with ESMTP id <S269001AbRHGQYN>;
	Tue, 7 Aug 2001 12:24:13 -0400
Date: Tue, 7 Aug 2001 09:22:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Ben LaHaise <bcrl@redhat.com>
cc: Daniel Phillips <phillips@bonn-fries.net>,
        Rik van Riel <riel@conectiva.com.br>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>
Subject: Re: [RFC][DATA] re "ongoing vm suckage"
In-Reply-To: <Pine.LNX.4.33.0108071143080.30280-100000@touchme.toronto.redhat.com>
Message-ID: <Pine.LNX.4.31.0108070920440.31117-100000@cesium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 7 Aug 2001, Ben LaHaise wrote:
>
> I didn't try pre4.  pre5 is absolutely horrible.

Sorry, I should have warned people: pre5 is a test-release that was
intended solely for Leonard Zubkoff who has been helping with trying to
debug a FS livelock condition.

Try pre4.

		Linus

