Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262167AbSJNUNI>; Mon, 14 Oct 2002 16:13:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262168AbSJNUNI>; Mon, 14 Oct 2002 16:13:08 -0400
Received: from inrete-46-20.inrete.it ([81.92.46.20]:63212 "EHLO
	pdamail1-pdamail.inrete.it") by vger.kernel.org with ESMTP
	id <S262167AbSJNUNH>; Mon, 14 Oct 2002 16:13:07 -0400
Message-ID: <3DAB26A5.690471@inrete.it>
Date: Mon, 14 Oct 2002 22:18:45 +0200
From: Daniele Lugli <genlogic@inrete.it>
Organization: General Logic srl
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rthal5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: unhappy with current.h
References: <3DAB1F00.667B82B5@inrete.it> <20021014.125234.102091817.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Daniele Lugli <genlogic@inrete.it>
>    Date: Mon, 14 Oct 2002 21:46:08 +0200
> 
>    Moral of the story: in my opinion kernel developers should reduce to a
>    minimum the use of #define, and preferably use words in uppercase and/or
>    with underscores, in any case not commonly used words.
> 
> Or maybe you should change your datastructure to not have member names
> the conflict with 7 year old well defined global symbols in the Linux
> kernel?

That's what I did.

What about, next time,

#define i j

??

Regards, DL
