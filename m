Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755173AbWKMQDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755173AbWKMQDG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755181AbWKMQDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:03:06 -0500
Received: from nf-out-0910.google.com ([64.233.182.187]:60696 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1755173AbWKMQDF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:03:05 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=mVpmIG5LI1+vNlpNuDqi629R97djV0Mn0GINuGdABTkHGU/f9pYHZvLoYqa6ZfM0ijV4sD9f3nNWumfgqmX5cE7K+KkryP+AmeGfv3abgPfA6BAyP6N1uDOShnJvStC+TBEEqQg3z4lrAmRDj8SR0MfiyT+vjDPLiv2OFZ9zO2Q=
Message-ID: <9a8748490611130803o4dbd05a5w6d271136db5e4378@mail.gmail.com>
Date: Mon, 13 Nov 2006 17:03:02 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Shaun Q" <shaun@c-think.com>
Subject: Re: Dual cores on Core2Duo not detected?
Cc: "Stephen Clark" <Stephen.Clark@seclark.us>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.BSO.4.64.0611130752270.21533@ref.nmedia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <Pine.BSO.4.64.0611122322060.30536@ref.nmedia.net>
	 <4558773A.4040803@seclark.us>
	 <Pine.BSO.4.64.0611130752270.21533@ref.nmedia.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/11/06, Shaun Q <shaun@c-think.com> wrote:
>
> On Mon, 13 Nov 2006, Stephen Clark wrote:
>
> > Hi Shaun,
> >
> > Someone mentioned some bioses have an entry to enable the second core.
> >
...
> >
> Thanks Steve :)
>
> This bios does have such an entry and it is enabled.
>

What does   cat /proc/cpuinfo   show?
Any interresting info in  dmesg  ?
What kernel version exactely?
Could we have a copy of your .config ?

A shot in the dark: Are there any BIOS updates available for your system?

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
