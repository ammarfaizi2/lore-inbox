Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273666AbRI3QAX>; Sun, 30 Sep 2001 12:00:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273691AbRI3QAO>; Sun, 30 Sep 2001 12:00:14 -0400
Received: from fw.sthlm.cendio.se ([213.212.13.67]:15609 "EHLO
	jarlsberg.sthlm.cendio.se") by vger.kernel.org with ESMTP
	id <S273666AbRI3P77>; Sun, 30 Sep 2001 11:59:59 -0400
To: mingo@elte.hu (Ingo Molnar)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] netconsole-2.4.10-B1
In-Reply-To: <3BB52510.7D41538A@osdlab.org>
	<Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain>
From: Marcus Sundberg <marcus@cendio.se>
Date: 30 Sep 2001 18:00:10 +0200
In-Reply-To: <Pine.LNX.4.33.0109291146440.1715-100000@localhost.localdomain>
Message-ID: <ven13cd5yt.fsf@inigo.sthlm.cendio.se>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

mingo@elte.hu (Ingo Molnar) writes:

> sorry :-) definitions of netconsole-terms:
> 
> 'server': the host that is the source of the messages. Ie. the box that
>           runs the netconsole.o module. It serves log messages to the
>           client.
> 
> 'client': the host that receives the messages. This box is running the
>           netconsole-client.c program.

Then I guess you consider Mozilla to be a http-server, as it serves
http-requests to http-clients like Apache? ;)

Well, in any case it's a great patch even though the terminology is
backwards.

//Marcus
-- 
---------------------------------+---------------------------------
         Marcus Sundberg         |      Phone: +46 707 452062
   Embedded Systems Consultant   |     Email: marcus@cendio.se
        Cendio Systems AB        |      http://www.cendio.com
