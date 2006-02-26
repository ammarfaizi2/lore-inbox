Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751305AbWBZUoj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbWBZUoj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Feb 2006 15:44:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751370AbWBZUoi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Feb 2006 15:44:38 -0500
Received: from pproxy.gmail.com ([64.233.166.178]:36065 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751305AbWBZUoi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Feb 2006 15:44:38 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=r59GVdBEnJzp+bJFLlR1CRtvxlcy/e9EB1H1aBTvn6+XLHvh7DjpP/XvsKFWwMCYIhB8L7qeZYuqzfWDthC7VkkEKruw+FZJ5JSpxmNJAdJzrJJIzkhf/BW3Rn5Qzt1Uvlxl4WVG4VkmX/W+VqLBTJhYRXF0atsVkUEovqePdro=
Message-ID: <9a8748490602261244s6adf64ecsa0f6be18a81ce0@mail.gmail.com>
Date: Sun, 26 Feb 2006 21:44:37 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Lee Revell" <rlrevell@joe-job.com>
Subject: Re: Building 100 kernels; we suck at dependencies and drown in warnings
Cc: linux-kernel@vger.kernel.org, "Andrew Morton" <akpm@osdl.org>,
       "Sam Ravnborg" <sam@ravnborg.org>
In-Reply-To: <1140986578.24141.141.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200602261721.17373.jesper.juhl@gmail.com>
	 <1140986578.24141.141.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/06, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sun, 2006-02-26 at 17:21 +0100, Jesper Juhl wrote:
> > Hi everyone,
> >
> > I just sat down and build 100 kernels (2.6.16-rc4-mm2 kernels to be exact)
>
> What GCC version?

3.4.5

> 4.x still has the bug where it spews false warnings
> about things being used uninitialized.
>
> Lee
>


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
