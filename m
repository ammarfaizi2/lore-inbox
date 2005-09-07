Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751169AbVIGAoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751169AbVIGAoM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 20:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbVIGAoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 20:44:12 -0400
Received: from zproxy.gmail.com ([64.233.162.206]:6461 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751169AbVIGAoL convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 20:44:11 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=QoEKWdV6AmiYaw3NB937+VojRohOCsa/PC+fR7PRf+5u3H4MhCxSa6J7fTFqjJLn+9j14relguguKNfuWR3tPQQJmIQdjnRTcJu7j/+BLwBprOkLFOPYORYfckbyZMz9oozDWzD1PlELBK+Em2YS/ITCr9hNKmsj9Sq29CBxdqY=
Message-ID: <9a87484905090617444e89722d@mail.gmail.com>
Date: Wed, 7 Sep 2005 02:44:07 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Paul Jackson <pj@sgi.com>
Subject: Re: 2.6.13-mm1
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
In-Reply-To: <20050906170513.60ed024a.pj@sgi.com>
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
	 <20050906170513.60ed024a.pj@sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/7/05, Paul Jackson <pj@sgi.com> wrote:
> Andrew wrote"
> > So then I was asked to include an explanation
> > with the drop message and that all got too hard so I turned them off.
> >
> > <turns them back on again>
> 
> 
> Dang it, Andrew.  It didn't have to be hard.  Just adding a
> boiler plate sentence to all the drop messages saying something
> like:
> 
>         If I just sent the patch to Linus, that is
>         probably why I dropped it here.
> 
> That should be enough of a clue for most folks.

I agree completely. Something like that would be just fine for the
patches that have been sent on to Linus.


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
