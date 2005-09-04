Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbVIDVgq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbVIDVgq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 17:36:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbVIDVgq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 17:36:46 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:63295 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751178AbVIDVgp convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 17:36:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GXC6q3hLkXh0gngDnJKhlqT7j3FKJEQP3I3tFtVSEsnLYzlR37H54tPTFqLenOnihHAMtPe6Wesfm7Bk+mw1sG1wLS+ickG5mTuC/SYVZYbc+UGDrVSAaSd6ZNfMpFc321+0VFlX5QQwuPDCmE9wr7w++18xSV8/EXNfHHDNhM8=
Message-ID: <9a874849050904143675a9042@mail.gmail.com>
Date: Sun, 4 Sep 2005 23:36:37 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.13-mm1
Cc: bunk@stusta.de, linux-kernel@vger.kernel.org
In-Reply-To: <20050904143033.13a4bed3.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050901035542.1c621af6.akpm@osdl.org>
	 <20050903122126.GM3657@stusta.de>
	 <20050903123410.1320f8ab.akpm@osdl.org>
	 <20050903195423.GP3657@stusta.de>
	 <20050903130632.3124e19b.akpm@osdl.org>
	 <9a87484905090414245589a3c@mail.gmail.com>
	 <20050904143033.13a4bed3.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/4/05, Andrew Morton <akpm@osdl.org> wrote:
> Jesper Juhl <jesper.juhl@gmail.com> wrote:
> >
> > I'm wondering if it would be too much trouble to have a mm-drops list
> >  similar to the mm-commits list.
> 
> Well I was sending drop messages to mm-commits, but lots of people went
> "Waah, why did you drop my patch?".  A few hours after they'd been cc'ed as
> the patch went in to Linus!  So then I was asked to include an explanation
> with the drop message and that all got too hard so I turned them off.
> 

If patches dropped due to being merged in mainline were then commented
with a simple "merged in mainline" note, surely that would keep the
"Waah .." mails out of your mailbox. :-)

> <turns them back on again>
> 
> >  I also like to keep track of what patches of mine get accepted and
> >  subsequently dropped.
> 
> As I say, the way to do this is via your quilt series file.
> 
Hmm, I've been looking at quilt, but never really got to the point of
actually starting to use it - guess I should get started on that.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
