Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132338AbRDJQDp>; Tue, 10 Apr 2001 12:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132385AbRDJQDf>; Tue, 10 Apr 2001 12:03:35 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:57102 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132338AbRDJQDX>;
	Tue, 10 Apr 2001 12:03:23 -0400
Date: Tue, 10 Apr 2001 12:55:31 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Richard Russon <kernel@flatcap.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Swap Corruption in 2.4.3 ?
In-Reply-To: <986872810.8240.0.camel@home.flatcap.org>
Message-ID: <Pine.LNX.4.21.0104101254490.11038-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 Apr 2001, Richard Russon wrote:

> VM: Undead swap entry 000bb300
> VM: Undead swap entry 00abb300
> VM: Undead swap entry 016fb300

Known bug ... unknown cause ;(

http://www.linux-mm.org/bugzilla.shtml has it already listed

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

