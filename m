Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313635AbSDURbd>; Sun, 21 Apr 2002 13:31:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313638AbSDURbc>; Sun, 21 Apr 2002 13:31:32 -0400
Received: from 12-224-36-73.client.attbi.com ([12.224.36.73]:31243 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S313635AbSDURbb>;
	Sun, 21 Apr 2002 13:31:31 -0400
Date: Sun, 21 Apr 2002 09:29:52 -0700
From: Greg KH <greg@kroah.com>
To: Larry McVoy <lm@work.bitmover.com>, linux-kernel@vger.kernel.org
Subject: Re: [OFF TOPIC] BK license change
Message-ID: <20020421162952.GA28780@kroah.com>
In-Reply-To: <20020421095715.A10525@work.bitmover.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Sun, 24 Mar 2002 13:59:05 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 21, 2002 at 09:57:15AM -0700, Larry McVoy wrote:
> Well, now seems like a great time to discuss this.  Ha.
> 
> It's come to our attention that commercial companies are abusing BK under
> the openlogging rules.  To avoid paying for the product, they either put
> in no comments or obscure comments.  That is a violation of the license,
> but good luck proving that they are doing it on purpose.

Heh, I've seen real comments in the past that sure look like "no
comments or obscure comments".  This is usually done by people who don't
like to or know how to use checking comments correctly, not them trying
to hide info purposely :)

> I'm considering a change to the BKL which says that N days after a
> changeset is made, that changeset (and its ancestory) must be available
> on a public bk server.  In other words, put a hard limit on how long
> you may hide.

One problem might be having access to a public BK server.  I know lots
of people who do not want to run BK on a publicly accessible server,
if for no other reason of not likening to run _any_ program they don't
have to on a publicly available server.

Other companies also have restrictions on allowing programs to be run
outside of their firewalls.  If they want to use bk on a project, with
this license change, they would have to convince the IT group to set up
a bk server for their repository, which at larger companies is very hard
to do :)

You might have to beef up bkbits.net if this change goes into effect,
just to handle the extra repositories that might show up there.

Personally I don't care about the license change, as all my repositories
are placed on bkbits.net, and I understand your frustrations with people
trying to work around the spirit of your license.

Good luck,

greg k-h
