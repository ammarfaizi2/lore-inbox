Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267748AbTAMNkx>; Mon, 13 Jan 2003 08:40:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267797AbTAMNkx>; Mon, 13 Jan 2003 08:40:53 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:26763 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267748AbTAMNkv> convert rfc822-to-8bit; Mon, 13 Jan 2003 08:40:51 -0500
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Dave Jones <davej@codemonkey.org.uk>, Rob Wilkens <robw@optonline.net>
Subject: Re: any chance of 2.6.0-test*?
Date: Mon, 13 Jan 2003 14:49:14 +0100
User-Agent: KMail/1.4.3
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Christoph Hellwig <hch@infradead.org>, Greg KH <greg@kroah.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       William Lee Irwin III <wli@holomorphy.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44.0301121100380.14031-100000@home.transmeta.com> <1042400094.1208.26.camel@RobsPC.RobertWilkens.com> <20030113130842.GE9031@codemonkey.org.uk>
In-Reply-To: <20030113130842.GE9031@codemonkey.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301131449.14893.oliver@neukum.name>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 13. Januar 2003 14:08 schrieb Dave Jones:
> On Sun, Jan 12, 2003 at 02:34:54PM -0500, Rob Wilkens wrote:
>  > I'm REALLY opposed to the use of the word "goto" in any code where it's
>  > not needed.  OF course, I'm a linux kernel newbie, so I'm in no position
>  > to comment
>
> Someone want to add this one to the lkml faq (does anyone actually
> read that these days?) or maybe http://www.kernelnewbies.org/faq/
>
> Wow, one week later, and this would tie in with the fourth anniversary
> of someone else[2] making an ass of himself on this issue[1]

So let us rejoice in a story of human growth.
In the exuberant spirit of this joyfull occasion, I'd like you to find
a place for this memorative piece of code:

if (a->sibling->present)
	goto your_place;
else
	goto my_place;

	Regards
		Oliver

