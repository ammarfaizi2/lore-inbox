Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbVIZSvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbVIZSvY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 14:51:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932475AbVIZSvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 14:51:24 -0400
Received: from zproxy.gmail.com ([64.233.162.193]:42304 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932476AbVIZSvW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 14:51:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WeE+b9DMMeDsl4UeEWiL2VUxHFMLQfqGBSTtUwyk46dmhgB/yHwN6t9vfErEQ6qHy6pmJ8jfy/PW085zOT7hSq0rnMxkL59JI7QQcUi/ayY5oEuBU8XnwNaFxt1eOuk94WC+tsKM4eMX3Q7BQC6VA09IBXHpaR2Tz7MzycJd/zo=
Message-ID: <9a8748490509261151bb10b67@mail.gmail.com>
Date: Mon, 26 Sep 2005 20:51:20 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Prasant Gopal <prasant_a@students.iiit.net>
Subject: Re: Reg. gcc
Cc: linux-gcc@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.61.0509270009110.14218@students.iiit.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.61.0509270009110.14218@students.iiit.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/26/05, Prasant Gopal <prasant_a@students.iiit.net> wrote:
>
>
> hi ,
>
>            can i hav 2 versions of gcc installed on the same kernel..  If
> so how...please help me out...
>

If you have one, two, or more different versions of a userland program
(which gcc is) installed, is nothing the kernel cares about. This is a
userspace problem, not a kernel problem.

There is plenty of documentation to be found via google and other
sources that describe how to accomplish what you want to do - spend a
little time searching.

Here's one document that describes an installation of multiple gcc
versions (and there are lots of others out there) :
http://www.tellurian.com.au/whitepapers/multiplegcc.php

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
