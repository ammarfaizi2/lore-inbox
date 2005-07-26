Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261658AbVGZFnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261658AbVGZFnR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Jul 2005 01:43:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261678AbVGZFnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Jul 2005 01:43:17 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:17021 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261658AbVGZFnP convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Jul 2005 01:43:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=MJ8+xJJrcE050jDm1M0AjkxeJ4zcib4R0iPmYBfme14pHynUr8jCTY1twdt0rgahLPOBtm5QxXp5SsqpejV9aHLqqTweZvGWM6MtBQqRveTGgj1Gt3d9dn9fcHNu6VAJi3CsouM6dW6IOBHQXD+6eh9S9cLwscklnsPwhf9YNUY=
Message-ID: <feed8cdd050725224213df2d11@mail.gmail.com>
Date: Mon, 25 Jul 2005 22:42:43 -0700
From: Stephen Pollei <stephen.pollei@gmail.com>
Reply-To: Stephen Pollei <stephen.pollei@gmail.com>
To: Lee Revell <rlrevell@joe-job.com>
Subject: Re: ZyXEL Kernel /BusyBox GPL violation?
Cc: mmoneta@optonline.net, linux-kernel@vger.kernel.org, andersen@codepoet.org
In-Reply-To: <1122348483.1472.90.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1122348062.26341.50.camel@mmouse.moneta.optonline.net>
	 <1122348483.1472.90.camel@mindpipe>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/25/05, Lee Revell <rlrevell@joe-job.com> wrote:
> On Mon, 2005-07-25 at 23:21 -0400, Mace Moneta wrote:
> > The response seems meaningless; does this constitute a violation of
> > GPL?
> > If so what, if any, action needs to be taken?

http://gpl-violations.org/
http://www.fsf.org/licensing/licenses/gpl-faq.html#ReportingViolation
http://www.fsf.org/licensing/licenses/gpl-violation.html
[[[You should report it. First, check the facts as best you can. Then
tell the publisher or copyright holder of the specific GPL-covered
program. If that is the Free Software Foundation, write to
<license-violation@gnu.org>. Otherwise, the program's maintainer may
be the copyright holder, or else could tell you how to contact the
copyright holder, so report it to the maintainer.]]]

> Also if they didn't modify the kernel, they don't have to give you
> source, they can just refer you to kernel.org.

Wrong.....

http://www.fsf.org/licensing/licenses/gpl-faq.html#DistributeWithSourceOnInternet
[[[I want to distribute binaries without accompanying sources. Can I
provide source code by FTP instead of by mail order?
    You're supposed to provide the source code by mail-order on a
physical medium, if someone orders it. You are welcome to offer people
a way to copy the corresponding source code by FTP, in addition to the
mail-order option, but FTP access to the source is not sufficient to
satisfy section 3 of the GPL.

    When a user orders the source, you have to make sure to get the
source to that user. If a particular user can conveniently get the
source from you by anonymous FTP, fine--that does the job. But not
every user can do such a download. The rest of the users are just as
entitled to get the source code from you, which means you must be
prepared to send it to them by post.

    If the FTP access is convenient enough, perhaps no one will choose
to mail-order a copy. If so, you will never have to ship one. But you
cannot assume that.

    Of course, it's easiest to just send the source with the binary in
the first place. ]]]

http://www.fsf.org/licensing/licenses/gpl-faq.html#TOCSourceAndBinaryOnDifferentSites
[[[Can I put the binaries on my Internet server and put the source on
a different Internet site?
    The GPL says you must offer access to copy the source code "from
the same place"; that is, next to the binaries. However, if you make
arrangements with another site to keep the necessary source code
available, and put a link or cross-reference to the source code next
to the binaries, we think that qualifies as "from the same place".

    Note, however, that it is not enough to find some site that
happens to have the appropriate source code today, and tell people to
look there. Tomorrow that site may have deleted that source code, or
simply replaced it with a newer version of the same program. Then you
would no longer be complying with the GPL requirements. To make a
reasonable effort to comply, you need to make a positive arrangement
with the other site, and thus ensure that the source will be available
there for as long as you keep the binaries available. ]]]

http://www.fsf.org/licensing/licenses/gpl.html
Section 3 mentions three choices of what you must do to copy and distribute:
a) Have it from the same location. They have not.
b) Have written offer good for three years.... None such mentioned.
c) Be noncommercial plus send some information. zyxel.com "seller of
routers" sounds like a commercial enterprise to me.

So no they must assume responsibility to have the sources availible
even if they didn't modify them.

-- 
http://dmoz.org/profiles/pollei.html
http://sourceforge.net/users/stephen_pollei/
http://www.orkut.com/Profile.aspx?uid=2455954990164098214
http://stephen_pollei.home.comcast.net/
