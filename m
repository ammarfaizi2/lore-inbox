Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161976AbWLAVkr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161976AbWLAVkr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 16:40:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161977AbWLAVkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 16:40:46 -0500
Received: from wr-out-0506.google.com ([64.233.184.226]:23199 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1161976AbWLAVko (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 16:40:44 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=hBOZaLgGXd4f74nz6TwaJvnU+iQWCdzD4YyMGpT1XjZgn3AF0F2nFoMvGi+C7S7GecDizdUp9V0j4koNFY84NIjxTbHPdutFYKZhxdynuScx41jmayJ9YJLpQiCXRarwlUo/keAHI2hx/g9iBT8JdiTKgITNKM5NJd4/ws8eaVw=
Message-ID: <9a8748490612011340w75199a6co91c233f71f4090f6@mail.gmail.com>
Date: Fri, 1 Dec 2006 22:40:43 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Hua Zhong" <hzhong@gmail.com>
Subject: Re: [2.6 patch] Tigran Aivazian: remove bouncing email addresses
Cc: "Adrian Bunk" <bunk@stusta.de>, tigran@aivazian.fsnet.co.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <00e401c7150e$061da500$6721100a@nuitysystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061201055145.GK11084@stusta.de>
	 <00e401c7150e$061da500$6721100a@nuitysystems.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/12/06, Hua Zhong <hzhong@gmail.com> wrote:
> I am curious, what's the point?
>
> These email addresses serve a "historical" purpose: they tell when the contribution was made,  what the author's email addresses
> were at that point.
>
> It's not MAINTAINERS. If people want to contact someone, go find the latest address there.
>
Yes, MAINTAINERS is the preferred location for maintainer info, but
when there is no entry in maintainers (or when the person listed there
is not responsive), many people (including me) use the names or email
addresses listed in source files as people to contact. So it's nice
when the email addresses are up to date.

In my opinion the addresses should be working ones or not present at
all (or at the very least there should be a note that the email
address is outdated).

-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
