Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129351AbRCEP0a>; Mon, 5 Mar 2001 10:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129346AbRCEP0K>; Mon, 5 Mar 2001 10:26:10 -0500
Received: from brutus.conectiva.com.br ([200.250.58.146]:6389 "EHLO
	imladris.rielhome.conectiva") by vger.kernel.org with ESMTP
	id <S129323AbRCEPZ6>; Mon, 5 Mar 2001 10:25:58 -0500
Date: Mon, 5 Mar 2001 11:30:14 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Christoph Rohland <cr@sap.com>
cc: Matt_Domsch@Dell.com, linux-kernel@vger.kernel.org, R.E.Wolff@BitWizard.nl,
        fluffy@snurgle.org
Subject: Re: 2.4 and 2GB swap partition limit
In-Reply-To: <m3n1b0h9t3.fsf@linux.local>
Message-ID: <Pine.LNX.4.21.0103051129490.5591-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Mar 2001, Christoph Rohland wrote:

> BTW often these big servers run databases and application servers
> which have most of their memory in shared memory. Shared memory does
> free the swap entries on swapin. (I thought about changing that but as
> long as we have no garbage collection for idle swap entries I will not
> do it)

It's on my infinite TODO list ;)

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

