Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265054AbUEYTQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265054AbUEYTQO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:16:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbUEYTQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:16:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33933 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S265051AbUEYTP0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:15:26 -0400
Date: Tue, 25 May 2004 15:15:14 -0400 (EDT)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Andrea Arcangeli <andrea@suse.de>
cc: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Phy Prabab <phyprabab@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: Re: 4g/4g for 2.6.6
In-Reply-To: <20040524124834.GB29378@dualathlon.random>
Message-ID: <Pine.LNX.4.44.0405251514490.26157-100000@chimarrao.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 May 2004, Andrea Arcangeli wrote:
> On Mon, May 24, 2004 at 10:25:22AM +0200, Ingo Molnar wrote:
> > on how quickly 'x86 with more than 4GB of RAM' and 
> 
> s/4GB/32GB/
> 
> my usual x86 test box has 48G of ram (though to keep an huge margin of
> safety we assume 32G is the very safe limit).

Just how many 3GB sized processes can you run on that
system, if each of them have a hundred or so VMAs ?

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan

