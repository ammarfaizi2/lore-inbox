Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284890AbSAPRZG>; Wed, 16 Jan 2002 12:25:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284180AbSAPRY6>; Wed, 16 Jan 2002 12:24:58 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61713 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S284285AbSAPRXe>; Wed, 16 Jan 2002 12:23:34 -0500
Date: Wed, 16 Jan 2002 09:22:56 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Christoph Rohland <cr@sap.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Why not "attach" patches?
In-Reply-To: <m31ygqldr3.fsf@linux.local>
Message-ID: <Pine.LNX.4.33.0201160920020.1832-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 16 Jan 2002, Christoph Rohland wrote:
>
> On Tue, 15 Jan 2002, Linus Torvalds wrote:
> > Wrong.
> >
> > If I get a patch in an attachment (other than a "Text/PLAIN" type
> > attachment with no mangling and that pretty much all mail readers
> > and all tools will see as a normal body),
>
> So text/plain is ok for you?

text/plain is fine - it has all the properties a non-attachment has.

> How about multiple cummulative patches attached to one mail?

Absolutely not.  When I open my mail-client, and somebody has sent me 20
patches, I want to _see_ 20 mails. That way I can select from them, and
the mailreader clearly indicates which ones I've read, etc etc.

Multiple attachements have no advantages, and have several disadvantages.

> This is the case where I hate your strategy about attachments: You
> want to have separate patches (what I clearly understand), but you do
> not want attachments. That's fine most of the time as long as I send
> it to you privately, but to public lists too many people miss the
> important steps.

Sending large patches to public lists tends to be a mistake in the first
place. It just irritates the people who pay for bandwidth and do not want
to apply patches off the list.

		Linus

