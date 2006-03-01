Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932633AbWCAAdn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932633AbWCAAdn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 19:33:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932634AbWCAAdm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 19:33:42 -0500
Received: from pproxy.gmail.com ([64.233.166.180]:12305 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932633AbWCAAdm convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 19:33:42 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rr3fItT8tVWtOjbcAEN9mIVja0IenG4L+pA0wUITU95zOwhw9p/lkuMXHlJ/ptOnvyzto7crjWp4gfCAyNwPW/gEcp2XmEqYM2Zv3DjOH/A9+G5WOYyno87a3uJm81zofFfv7vpJK1x/sIRwJWK3u3gF/XmwQ/PBJSchvsoMDCE=
Message-ID: <9a8748490602281633m33541c7dy5d64925de7505656@mail.gmail.com>
Date: Wed, 1 Mar 2006 01:33:40 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm1
Cc: "Laurent Riffard" <laurent.riffard@free.fr>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, "Martin Bligh" <mbligh@mbligh.org>,
       "Christoph Lameter" <clameter@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <20060228162157.0ed55ce6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	 <4404CE39.6000109@liberouter.org>
	 <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	 <4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Andrew Morton <akpm@osdl.org> wrote:
> Laurent Riffard <laurent.riffard@free.fr> wrote:
> >
> > BUG: unable to handle kernel NULL pointer dereference at virtual address 00000034
>
> I booted that thing on five machines, four architectures :(
>
> Could people please test a couple more patchsets, see if we can isolate it?
>
Sure, no problem. But it'll have to wait until tomorrow evening for me
- I have to get some sleep now or I won't ever be able to get up and
get to work tomorrow... But I'll test those as soon as I get home
tomorrow.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
