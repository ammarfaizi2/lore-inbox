Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133106AbRAHRhW>; Mon, 8 Jan 2001 12:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135469AbRAHRhC>; Mon, 8 Jan 2001 12:37:02 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:27632 "EHLO
	brutus.conectiva.com.br") by vger.kernel.org with ESMTP
	id <S135467AbRAHRhB>; Mon, 8 Jan 2001 12:37:01 -0500
Date: Mon, 8 Jan 2001 15:36:23 -0200 (BRDT)
From: Rik van Riel <riel@conectiva.com.br>
To: afei@jhu.edu
cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: MM/VM todo list
In-Reply-To: <Pine.GSO.4.05.10101081230560.23656-100000@aa.eps.jhu.edu>
Message-ID: <Pine.LNX.4.21.0101081535330.21675-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 8 Jan 2001 afei@jhu.edu wrote:

> About the RSS ulimit proposal, have we resolved the correctness
> of counting RSS in a process?

I have not taken^Whad the time to check the kernel tree
and see if the RSS counting has indeed been made safe
everywhere.

regards,

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
