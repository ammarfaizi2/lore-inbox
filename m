Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136001AbRAGQzp>; Sun, 7 Jan 2001 11:55:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136033AbRAGQzf>; Sun, 7 Jan 2001 11:55:35 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:13296 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S136001AbRAGQzS>; Sun, 7 Jan 2001 11:55:18 -0500
Date: Sun, 7 Jan 2001 14:55:01 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: Jim Olsen <jim@browsermedia.com>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Which kernel fixes the VM issues?
In-Reply-To: <01010706312902.10913@jim.cyberjunkees.com>
Message-ID: <Pine.LNX.4.21.0101071454060.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2001, Jim Olsen wrote:

> Hi... I have a question or two that would help me clear up a bit of the fuzz 
> I have relating to the VM: do_try_to_free_pages issue.  

> My question is, exactly which kernel should I use in order to
> rid my server of this VM issue?

2.2:  2.2.19pre2 and later
2.4:  2.4.0  (and later ;))

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to loose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
