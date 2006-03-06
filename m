Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751961AbWCFSxS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751961AbWCFSxS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 13:53:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752075AbWCFSxS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 13:53:18 -0500
Received: from wproxy.gmail.com ([64.233.184.199]:38471 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751961AbWCFSxR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 13:53:17 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=WZoMpAMFXEliFybybkaipzD9LqHR/6sifQLH5LDTRU4KzMHVXXszB0pzMc+2U7RXtZddQUgg4tdADwxoKLAlQVVP+9LXiviXYq4O75xR1EGY/SFT6K3yLJ0qWovaS81YYGD2oIs/dpQgTwN9fZ0OIYcw9g33oTlbS3qxzxTKCcA=
Message-ID: <9a8748490603061053y359c7c8cv3af1d4e16d9bc5a0@mail.gmail.com>
Date: Mon, 6 Mar 2006 19:53:16 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Pavel Machek" <pavel@ucw.cz>
Subject: Re: Coverity Open Source Defect Scan of Linux
Cc: "Ben Chelf" <ben@coverity.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060306183318.GA3825@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <440BCA0F.50501@coverity.com> <20060306183318.GA3825@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/06, Pavel Machek <pavel@ucw.cz> wrote:
> On Ne 05-03-06 21:35:11, Ben Chelf wrote:
> > Hello Linux Developers,
> >
> >   I'm the CTO of Coverity, Inc., a company that does static source code
> > analysis to look for defects in code. You may have heard of us or of our
> > technology from its days at Stanford (the "Stanford Checker"). The
> > reason I'm writing is because we have set up a framework internally to
> > continually scan open source projects and provide the results of our
> > analysis back to the developers of those projects. Linux is one of the
> > 32 projects currently scanned at:
> >
> > http://scan.coverity.com
> >
> >   My belief is that we (Coverity) must reach out to the developers of
> > these packages (you) in order to make progress in actually fixing the
> > defects that we happen to find, so this is my first step in that
> > mission. Of course, I think Coverity technology is great, but I want
>
> Could you just open the (kernel) results to the public? Going after
> warnings from compiler (afaics that's roughly what coverity is) is
> ideal janitorial job, and job where many people -- not only core
> developers -- can help.
>                                                                 Pavel

I agree.

Cleaning some of this stuff up is something that I would be prepared
to work on, but I honestly can't be bothered to have to "register"
with coverity for the privilege of seeing the bug-reports...

Linux is a public project, just make the bug-reports/check results
public somewhere so we can all work on them.

--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
