Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291241AbSBGTrD>; Thu, 7 Feb 2002 14:47:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291246AbSBGTqx>; Thu, 7 Feb 2002 14:46:53 -0500
Received: from ns1.alcove-solutions.com ([212.155.209.139]:28168 "EHLO
	smtp-out.fr.alcove.com") by vger.kernel.org with ESMTP
	id <S291241AbSBGTqp>; Thu, 7 Feb 2002 14:46:45 -0500
Date: Thu, 7 Feb 2002 20:46:27 +0100
From: Stelian Pop <stelian.pop@fr.alcove.com>
To: Larry McVoy <lm@work.bitmover.com>,
        Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-2.5.4-pre1 - bitkeeper testing
Message-ID: <20020207194627.GA9057@come.alcove-fr>
Reply-To: Stelian Pop <stelian.pop@fr.alcove.com>
In-Reply-To: <20020207080714.GA10860@come.alcove-fr> <Pine.LNX.4.33.0202070833400.2269-100000@athlon.transmeta.com> <20020207092640.P27932@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20020207092640.P27932@work.bitmover.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 07, 2002 at 09:26:40AM -0800, Larry McVoy wrote:

> On Thu, Feb 07, 2002 at 08:36:20AM -0800, Linus Torvalds wrote:
> > 
> > For those people, "bk send -d torvalds@transmeta.com" is fine. It ends up
> 
> No!  This will send the entire repository.  

It will probably happen... :-)

> Do a "bk help send", you probably
> want "bk send -d -r+ torvalds@transmeta.com" to send the most recent cset.

I'd really like 'bk send' to drop me to a shell/mailer like and
ask for confirmation before sending the mail (and eventually add
for example the cc: line to l-k).

What I found easier to use is to 'bk send - > /tmp/foo' then send 
foo using my regular mailer... But I lose the advantages of
checking the last sended ChangeSet (in Bitkeeper/etc/send-a@b.com).

Stelian.
-- 
Stelian Pop <stelian.pop@fr.alcove.com>
|---------------- Free Software Engineer -----------------|
| Alcôve - http://www.alcove.com - Tel: +33 1 49 22 68 00 |
|------------- Alcôve, liberating software ---------------|
