Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932249AbVJIIiK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVJIIiK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 04:38:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932248AbVJIIiK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 04:38:10 -0400
Received: from nproxy.gmail.com ([64.233.182.205]:17963 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932249AbVJIIiJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 04:38:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=HGvmjgjzg3sLMGV+LP1hnj0hzIwqVZSuYj/+Ja9+z11uGAElCl4SHNIw3A9IBKa0xHma9R+J/IkiRHdrLN6DY3yBiXzReVM+q773z3EBj1lllPp142/oF5Yqt39xZ9i3p73toW9wzDC9C854WwFD01CTz+Xyry1i2EzF/uQt/fc=
Message-ID: <2cd57c900510090138h664e6c7eyad534f556b464c46@mail.gmail.com>
Date: Sun, 9 Oct 2005 16:38:07 +0800
From: Coywolf Qi Hunt <coywolf@gmail.com>
To: "Valdis.Kletnieks@vt.edu" <Valdis.Kletnieks@vt.edu>
Subject: Re: "stable" vs "security stable"
Cc: webmaster@kernel.org, lkml <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, security@kernel.org,
       stable@kernel.org
In-Reply-To: <200510090826.j998QG4H012803@turing-police.cc.vt.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <2cd57c900510082307q1841ce8dob1dce3b24edf4ad0@mail.gmail.com>
	 <200510090714.j997Ek2i032551@turing-police.cc.vt.edu>
	 <2cd57c900510090044o249258cbycf8afab644902e7@mail.gmail.com>
	 <200510090826.j998QG4H012803@turing-police.cc.vt.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/9/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> On Sun, 09 Oct 2005 15:44:38 +0800, Coywolf Qi Hunt said:
> > On 10/9/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
>
> > It is "security stable". Let's take this new notation from now on.
> > "Security Stable" doesn't have to be all security related.
>
> Tell you what - you convince the -stable team, and I'll go along with it..
>

Better be "stable" and "base". 2.6.13.3 is the latest stable, 2.6.13
is the latest base.

> > (you want stable@kernel.org to replace security@kernel.org too?)
>
> You're the one who called it "security stable" ;)

My fault. I didn't realise stable@kernel.org exist, and CCed the wrong
list security@kernel.org.

>
> > What you did is so stupid to me to to use -R every time. -R implies
> > something wrong, and need to revert.
>
> Umm... my diff had *lower case* -r (recursive), not -R (revert)...

I mean `patch -R'.
--
Coywolf Qi Hunt
http://sosdg.org/~coywolf/
