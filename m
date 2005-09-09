Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751428AbVIINpH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751428AbVIINpH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 09:45:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751429AbVIINpH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 09:45:07 -0400
Received: from zproxy.gmail.com ([64.233.162.202]:61366 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751428AbVIINpF convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 09:45:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=U3ANDvX7IpXwxZ8dufHQoPBWyV/JtQQfitTakkdnmJ+ZFfLLa9NO/R11y5q763KIBuvO94mfP5CiyAsZqhVNeAfw/S9JAotGAfKPTv/thy+l5Ze+ja7zoEzdwqG/HM6YqV7hx+nZOLg0bThunj5utLNSqaBtfAb6Sldh+tDGIgc=
Message-ID: <9a87484905090906446a3c3bf5@mail.gmail.com>
Date: Fri, 9 Sep 2005 15:44:57 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: jesper.juhl@gmail.com
To: Jan Beulich <JBeulich@novell.com>
Subject: Re: [PATCH] rmmod notifier chain
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <43219FDF0200007800024975@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43206EFE0200007800024451@emea1-mh.id2.novell.com>
	 <20050908151624.GA11067@infradead.org>
	 <432073610200007800024489@emea1-mh.id2.novell.com>
	 <20050908184659.6aa5a136.akpm@osdl.org>
	 <43219FDF0200007800024975@emea1-mh.id2.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/9/05, Jan Beulich <JBeulich@novell.com> wrote:
[snip]
> 
> First, I rarely saw any kind of positive review feedback from lkml
> besides the notification that you added something to your -mm tree
> (negative things of course always arrive), yet no feedback at all is far
[snip]

I wouldn't say only negative feedback is the general rule. 
I've posted lots of patches where people have send comments like
"looks good", "thanks, applied", "generally OK, but please change this
or that little bit", etc... And I see the same for many other peoples
patches.  Positive feedback does happen.

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
