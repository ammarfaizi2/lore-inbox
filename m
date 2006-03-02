Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932446AbWCBUQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932446AbWCBUQe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 15:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWCBUQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 15:16:34 -0500
Received: from zproxy.gmail.com ([64.233.162.204]:1051 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932446AbWCBUQe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 15:16:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=VqmI2svPBsyc6RioD1Cc4+3QQSUVSbVHCGvM46lQaofMRmdOOna04KP60YVTefeAkmSHnC3SvIy3gozi8BVtg6IcJ4N/cGmzNmkZygjyJ1aeS9wVH1fa0GYyE7hHbTTURtjWuKLDtZ0Y5tzXP9UnB31vj5gc95ZPkebriA9O0Dk=
Message-ID: <9a8748490603021216u344a3915g6ca0df42bb51b867@mail.gmail.com>
Date: Thu, 2 Mar 2006 21:16:32 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm1
Cc: "Laurent Riffard" <laurent.riffard@free.fr>, linux-kernel@vger.kernel.org,
       "Rafael J. Wysocki" <rjw@sisk.pl>, "Martin Bligh" <mbligh@mbligh.org>,
       "Christoph Lameter" <clameter@engr.sgi.com>,
       "Eric W. Biederman" <ebiederm@xmission.com>
In-Reply-To: <9a8748490603011741o122e652ica20a9fcffed3d41@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	 <4404CE39.6000109@liberouter.org>
	 <9a8748490602281430x736eddf9l98e0de201b14940a@mail.gmail.com>
	 <4404DA29.7070902@free.fr> <20060228162157.0ed55ce6.akpm@osdl.org>
	 <9a8748490603011741o122e652ica20a9fcffed3d41@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/06, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 3/1/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > Could people please test a couple more patchsets, see if we can isolate it?
> >
> > http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
> >
>
> Haven't had time to test this one yet, and won't have time until tomorrow :(
>

I just tested this kernel and it builds and runs just fine. Can't
crash it with my eclipse test case.

>
> > and http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.2.gz is
>
> I've tested this one and I can't crash it with eclipse like I could
> plain old 2.6.16-rc5-mm1
>

With all the recent patches and proposed patches and discussions about
various approaches to fix this I've lost track.

What kernel with what patches applied and/or reverted would it make
the most sense for me to test now, in order to provide the most useful
testing?


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
