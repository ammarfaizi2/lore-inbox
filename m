Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbVKNAfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbVKNAfG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Nov 2005 19:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750810AbVKNAfF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Nov 2005 19:35:05 -0500
Received: from zproxy.gmail.com ([64.233.162.200]:10736 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750809AbVKNAfE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Nov 2005 19:35:04 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JX/i5fPLFy9ccqcA0SpHJn4KsAN/67nWkwKAcxFktX3P7nETicOfAM0sC5fgvQYrHKYCzcj9hEraIIpU/jQBeNbo9xCUVxvt8zpvIZWB38yabc/Y9/EJXJTf5+wq4lJ5z1I10vUR6HIo865XFNDs+HDHwmJs7DA8vmd6y2dre2o=
Message-ID: <9a8748490511131635p2663cd14k964cf18515ad9f66@mail.gmail.com>
Date: Mon, 14 Nov 2005 01:35:03 +0100
From: Jesper Juhl <jesper.juhl@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Modules are missed while compiling the same version of kernel
Cc: Neo Jia <cjia@cse.unl.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <1131822591.15223.5.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <43756131.5020702@cse.unl.edu>
	 <9a8748490511120634h64a74359s59e4eab3ca8fdda2@mail.gmail.com>
	 <1131822591.15223.5.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/12/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Sat, 2005-11-12 at 15:34 +0100, Jesper Juhl wrote:
> > You are adding the -rt patchset, the changes in there could also
> > account for some of the difference although I must admit I don't know
> > exactely what changes the -rt patchset makes - I've never really
> > looked at it.
>
> Actually he's talking about RTLinux, which is a commercial product.  He
> needs to contact his support rep.  Or depending on the nature of his RT
> constraints, consider the -rt kernel.
>
Ohh, whoopsie, I thought he was talking about Ingo's -rt patches.
Thank you for clearing that up.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
