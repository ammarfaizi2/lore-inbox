Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132261AbRAQFAD>; Wed, 17 Jan 2001 00:00:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132442AbRAQE7y>; Tue, 16 Jan 2001 23:59:54 -0500
Received: from [129.94.172.186] ([129.94.172.186]:40945 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id <S132261AbRAQE7j>; Tue, 16 Jan 2001 23:59:39 -0500
Date: Wed, 17 Jan 2001 15:59:38 +1100 (EST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@localhost.localdomain>
To: Boszormenyi Zoltan <zboszor@externet.hu>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.0-vmbigpatch compile problem
In-Reply-To: <Pine.LNX.4.02.10101091023170.22614-100000@prins.externet.hu>
Message-ID: <Pine.LNX.4.31.0101171559070.5464-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 Jan 2001, Boszormenyi Zoltan wrote:

> PF_RSSTRIM is not declared anywhere either in the linux-2.4.0
> sources or in the 2.4.0-vmbigpatch.

Humm, I seem to have forgotten a `cp $i $i.orig`  ;)

Should be fixed in a newer patch.

regards,

-- 
Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
