Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273429AbRIRT3P>; Tue, 18 Sep 2001 15:29:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273425AbRIRT25>; Tue, 18 Sep 2001 15:28:57 -0400
Received: from host154.207-175-42.redhat.com ([207.175.42.154]:77 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S273424AbRIRT2m>; Tue, 18 Sep 2001 15:28:42 -0400
Date: Tue, 18 Sep 2001 15:29:05 -0400
From: Benjamin LaHaise <bcrl@redhat.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Alexander Viro <viro@math.psu.edu>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.10-pre11
Message-ID: <20010918152905.C8713@redhat.com>
In-Reply-To: <Pine.GSO.4.21.0109181354470.27125-100000@weyl.math.psu.edu> <Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0109181122550.9711-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Tue, Sep 18, 2001 at 11:27:27AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 11:27:27AM -0700, Linus Torvalds wrote:
> I don't have that feeling. I'm happy with having partial merge with ugly
> warts, if it means that you can get to the final stage _without_ having to
> have all the problems fixed at one time.
> 
> So now we have two _smaller_ merges that will fix two other issues, and
> remove all the horridness from the original merge.

A lot of us would be much happier if you just renamed 2.4.10pre11 to 2.5.1. =)
Then we can backport things as they become stable.

		-ben
