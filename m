Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751356AbWCBBl0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751356AbWCBBl0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 20:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751357AbWCBBl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 20:41:26 -0500
Received: from zproxy.gmail.com ([64.233.162.206]:31343 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751356AbWCBBlZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 20:41:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NFFXMyawaB09+38SUqdVvRb+85OTeMYyk++nHpsJp0FvFpCc7gyDpc9Z3vCZhTeWG5/0lYrzeAoqVGzouPxwunzAC7BTdfTQlFsc4EOIm7chb4In48NysfNjJ2Bv7h70CVRuXG7X+X+SN7he9Kp41KreznlVp+zyXIo0hW07mjI=
Message-ID: <9a8748490603011741o122e652ica20a9fcffed3d41@mail.gmail.com>
Date: Thu, 2 Mar 2006 02:41:23 +0100
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
>
> Could people please test a couple more patchsets, see if we can isolate it?
>
> http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.1.gz
>

Haven't had time to test this one yet, and won't have time until tomorrow :(


> and http://www.zip.com.au/~akpm/linux/patches/stuff/2.6.16-rc5-mm1.2.gz is

I've tested this one and I can't crash it with eclipse like I could
plain old 2.6.16-rc5-mm1


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
