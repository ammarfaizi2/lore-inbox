Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318258AbSIBKKc>; Mon, 2 Sep 2002 06:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318259AbSIBKKc>; Mon, 2 Sep 2002 06:10:32 -0400
Received: from dsl-213-023-021-067.arcor-ip.net ([213.23.21.67]:20104 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318258AbSIBKKb>;
	Mon, 2 Sep 2002 06:10:31 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "David S. Miller" <davem@redhat.com>
Subject: Re: [TRIVIAL PATCH] Remove list_t infection.
Date: Mon, 2 Sep 2002 12:16:45 +0200
X-Mailer: KMail [version 1.3.2]
Cc: wli@holomorphy.com, rml@tech9.net, rusty@rustcorp.com.au,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org, akpm@zip.com.au
References: <20020902060257.GO888@holomorphy.com> <E17loBW-0004gM-00@starship> <20020902.030553.14354294.davem@redhat.com>
In-Reply-To: <20020902.030553.14354294.davem@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17loGE-0004gS-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 02 September 2002 12:05, David S. Miller wrote:
>    From: Daniel Phillips <phillips@arcor.de>
>    Date: Mon, 2 Sep 2002 12:11:53 +0200
> 
>    On Monday 02 September 2002 08:20, David S. Miller wrote:
>    > The problem is, it isn't a "list", it's a "list header" or "list
>    > marker", ie. a list_head.
>    
>    No it's not, it's nothing more nor less than a list node, identically,
>    a list.
>    
> A list node is markably different from "the list" itself.
> 
> A "list" is the whole of all the nodes on the list, not just one
> of them.

Admit it, you never wrote a line of lisp ;-)

-- 
Daniel
