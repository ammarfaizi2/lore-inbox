Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276083AbRJBSIa>; Tue, 2 Oct 2001 14:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276087AbRJBSIU>; Tue, 2 Oct 2001 14:08:20 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:52472
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S276083AbRJBSID>; Tue, 2 Oct 2001 14:08:03 -0400
Date: Tue, 2 Oct 2001 11:08:25 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: ext3 0.9.10 for Alan's tree
Message-ID: <20011002110825.A1012@mikef-linux.matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <F295R5VX9q2TwOk6AIe0000f57a@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F295R5VX9q2TwOk6AIe0000f57a@hotmail.com>
User-Agent: Mutt/1.3.22i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 02, 2001 at 07:28:34AM +0000, sayamindu dasgupta wrote:
> Fr?d?ric L. W. Meunier wrote:
> 
> >Andrew Morton wrote:
> >
> >
> >>We prefer to test a lot before releasing, and the one time I
> >>skipped that step was for 2.4.10, and it was the one which is
> >>broken. Sigh.
> >>
> >
> >How broken ? I ask because I'm worried since I use it. Or
> >it's just the compilation problem with CONFIG_BUFFER_DEBUG
> >and nothing serious ?
> >
> >PS: I don't see any other reports on ext3-users.
> 
> hello
> i've been using it for a few weeks and i don't get any probs
> cheers
> Sayamindu

I don't think so...

2.4.10-pre11 was only released ~1 week ago...

The only reports of problems have been for adding a journal to a mounted
filesystem on 2.4.10pre11+. 
