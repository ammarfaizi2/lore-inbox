Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262389AbRGWWYu>; Mon, 23 Jul 2001 18:24:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262355AbRGWWYl>; Mon, 23 Jul 2001 18:24:41 -0400
Received: from smtprt15.wanadoo.fr ([193.252.19.210]:63952 "EHLO
	smtprt15.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S262288AbRGWWYY>; Mon, 23 Jul 2001 18:24:24 -0400
Message-ID: <3B5CA4CA.46B53843@wanadoo.fr>
Date: Tue, 24 Jul 2001 00:27:22 +0200
From: Jerome de Vivie <jerome.de-vivie@wanadoo.fr>
Organization: CoolSite
X-Mailer: Mozilla 4.74 [fr] (X11; U; Linux 2.4.4-sb i686)
X-Accept-Language: French, fr, en
MIME-Version: 1.0
To: Larry McVoy <lm@bitmover.com>
CC: linux-kernel@vger.kernel.org, linux-fsdev@vger.kernel.org,
        maritza@libertsurf.fr, rusty@rustcorp.com.au
Subject: Re: Yet another linux filesytem: with version control
In-Reply-To: <3B5C91DA.3C8073AC@wanadoo.fr> <20010723141751.W6820@work.bitmover.com> <3B5C9E95.8BF61D7A@wanadoo.fr> <20010723151457.C14194@work.bitmover.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Larry McVoy a écrit :
> 
> On Tue, Jul 24, 2001 at 12:00:53AM +0200, Jerome de Vivie wrote:
> > I absolutely don't know how much work it is. Will you work again on this
> > topic ?
> 
> Err, I've got a young but healthy company that is already doing it.  I'm
> happy to offer what advice I can to help you but I can't really commit
> substantial resources towards this.  I make my living off of my company
> and that has to come first.  That said, it's an interesting area and it's
> nice to see others take an interest, so I'll help a little...

Ok, thanks !

> 
> > To work on a file, we just break and copy the link. But, i don't see how
> > to work with 2 versions of the same file with hard link.
> 
> You don't want to do so.  You save little by doing so.  Please tell me you
> weren't going to version control at the block level, therein lies the path
> to insanity.  Getting it right at the file boundary is hard enough.

Yes, it was block level version control but it feets our needs ( I have 
scattered files across directories when there were no dependencies).

j.


-- 
Jerome de Vivie 	jerome . de - vivie @ wanadoo . fr
