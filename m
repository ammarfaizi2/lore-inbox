Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132858AbRDIWIH>; Mon, 9 Apr 2001 18:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132859AbRDIWH6>; Mon, 9 Apr 2001 18:07:58 -0400
Received: from garrincha.netbank.com.br ([200.203.199.88]:2576 "HELO
	netbank.com.br") by vger.kernel.org with SMTP id <S132858AbRDIWHr>;
	Mon, 9 Apr 2001 18:07:47 -0400
Date: Mon, 9 Apr 2001 19:00:33 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: Michael Peddemors <michael@linuxmagic.com>, linux-kernel@vger.kernel.org
Subject: Re: goodbye
In-Reply-To: <20010410010008.W805@mea-ext.zmailer.org>
Message-ID: <Pine.LNX.4.21.0104091857020.11038-100000@imladris.rielhome.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, Matti Aarnio wrote:

> 	Dave said "remove DUL", I did that.
> 	VGER uses now   RBL and RSS,  no others.

Thanks !

To come back to the spamfilter promise I made some time ago,
people can now get a CVS tree with spam regular expressions
and a script to generate a majordomo.cf from it ...

Scripts to automatically generate configuration for other
mailing list and mail delivery programs are very much welcome,
as are people willing to help maintain the set of regexps.


cvs -d :pserver:cvs@nl.linux.org:/home/CVS login
password: cvs
cvs -d :pserver:cvs@nl.linux.org:/home/CVS checkout spamfilter


The (majordomo-run) mailing list spamfilter@nl.linux.org will
be used for CVS updates and possibly discussion about this
thing. I'm already using a procmail rule to automatically do
a rebuild of NL.linux.org's majordomo.cf whenever something
is changed to the CVS tree...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

