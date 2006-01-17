Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964845AbWAQVEe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964845AbWAQVEe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 16:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932430AbWAQVEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 16:04:34 -0500
Received: from uproxy.gmail.com ([66.249.92.207]:11399 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932408AbWAQVEd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 16:04:33 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=AefwtmyWxXwgfOBZu5X4+tZpZiTYfMBoxexpJcuxsn62oQMAKpViYAPFnBnvatyQSc1XIg5ZyVD5wf12GnIlD/cuWaOuwXKJUE4DIqlG0Var2XXiJJDBZHbkc3qVxCV1aGqq4rt+p4nUD0IYfhow5S9by3/C2ZaDQRE1bIsSru8=
Message-ID: <69304d110601171304h34c16fbfuf59df390c0fc58fd@mail.gmail.com>
Date: Tue, 17 Jan 2006 22:04:31 +0100
From: Antonio Vargas <windenntw@gmail.com>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Linus Torvalds <torvalds@osdl.org>, Diego Calleja <diegocg@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.16-rc1
In-Reply-To: <Pine.LNX.4.61.0601172104350.11929@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.64.0601170001530.13339@g5.osdl.org>
	 <20060117183916.399b030f.diegocg@gmail.com>
	 <Pine.LNX.4.64.0601170946050.3240@g5.osdl.org>
	 <Pine.LNX.4.61.0601172104350.11929@yvahk01.tjqt.qr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/17/06, Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> Can I ask if it's possible to "mark" new features/important changes?
> >
> >Well, I'd rather not do it in the source control management itself, simply
> >because people are notoriously bad at deciding what is "important".
> >
> >It goes something like this: "By definition, anything _you_ work for is
> >crap and unimportant, while _my_ work is the most important thing ever,
> >even if it happens to be just fixing typos".
> >
> Important is what is important for all members of an "independent" group.
> We already have a small example: kerneltraffic. Though it's just one person
> and therefore possibly biased, the magazine picks out what's [deemed]
> important.
> Typos don't really advance to important IMO, even if they fix oopses (e.g.
> a missing ! somewhere). More important are world news, news that Joe
> Default User thinks is good - "full double preemption", "O(0.5) scheduler"
> and other illusory things. Just think of if you had to commercially sell
> a Linux kernel CD what features you would print on the cover.
> As for me, it was important to see SCHED_BATCH going in, as I started
> to look through the big changelog :)
> Well, my 2 euros. (Yeah, 200 cents!)
>

Maybe the way to make modern-style linux development (post 2.5) more
manageable for mere mortals is to stop integrating things when the
shortlog is so big that it can't be posted to the mailing list? Less
changes, easier to see if you are able to help testing ;)

--
Greetz, Antonio Vargas aka winden of network

http://wind.codepixel.com/
windNOenSPAMntw@gmail.com
thesameasabove@amigascne.org

Every day, every year
you have to work
you have to study
you have to scene.
