Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932210AbVJCJjy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932210AbVJCJjy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 05:39:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932212AbVJCJjy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 05:39:54 -0400
Received: from qproxy.gmail.com ([72.14.204.196]:1059 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932210AbVJCJjx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 05:39:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=qUIgUuVb/ekWg3Hxyw823mS7/fKKu4vI8jNFHeBwq+PKM9kabqhhmXy0kZnjTWqwH3hfOplF/+oZ0XRJ3WBQeqTLQe9EYxmHBGiaxyyS0DkcvBxyJ/GCZZFMUcoUlQz0MlZiT1t79TvdIPGxbXiMyJiQ19u1IL1dkXbj0JATIHQ=
Message-ID: <9a8748490510030239m2ef276a9w7949bcba1f705038@mail.gmail.com>
Date: Mon, 3 Oct 2005 11:39:52 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Gene Heskett <gene.heskett@verizon.net>
Subject: Re: what's next for the linux kernel?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200510022350.54640.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4TiWy-4HQ-3@gated-at.bofh.it>
	 <200510021932.00969.gene.heskett@verizon.net>
	 <Pine.LNX.4.63.0510021948180.27456@cuia.boston.redhat.com>
	 <200510022350.54640.gene.heskett@verizon.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, Gene Heskett <gene.heskett@verizon.net> wrote:
> On Sunday 02 October 2005 19:48, Rik van Riel wrote:
> >On Sun, 2 Oct 2005, Gene Heskett wrote:
> >> Ahh, yes and no, Robert.  The un-answered question, for that
> >> 512 processor Altix system, would be "but does it run things 512
> >> times faster?"  Methinks not, by a very wide margin.  Yes, do a lot
> >> of unrelated things fast maybe, but render a 30 megabyte page with
> >> ghostscript in 10 milliseconds?  Never happen IMO.
> >
> >You haven't explained us why you think your proposal
> >would allow Linux to circumvent Amdahl's law...
>
> Amdahl's Law?
>
http://en.wikipedia.org/wiki/Amdahl's_law
http://home.wlu.edu/~whaleyt/classes/parallel/topics/amdahl.html

And google has even more. Wonderful thing those search engines...


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
