Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273497AbRIQGIx>; Mon, 17 Sep 2001 02:08:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273494AbRIQGIn>; Mon, 17 Sep 2001 02:08:43 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:51957
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S272673AbRIQGId>; Mon, 17 Sep 2001 02:08:33 -0400
Date: Sun, 16 Sep 2001 23:08:52 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.2.20pre10
Message-ID: <20010916230852.E24067@mikef-linux.matchmail.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
In-Reply-To: <E15gwc5-0003VR-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E15gwc5-0003VR-00@the-village.bc.nu>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 12, 2001 at 12:06:41AM +0100, Alan Cox wrote:
> If you know any reason this should not be 2.2.20 final now is a very very
> good time to say. I intend to call this patch 2.2.20 in a week or so barring
> any last minute problems. Please save anything but actual bugfixes for
> 2.2.21.

OK, will test.

I know the Ingo's raid patch hasn't been included because of tool
compatibility problems.  Has anyone thought of having both versions in the
2.2 kernel?  Would this be trivial, or something that would change too much
for 2.2?

I've been compiling in Andre's EIDE patch for months, without any problems
on x86.  Except for an #include error on PPC.  I have a patch, but I can't
sent attach now because the patch is on a computer that is off at the moment...

Is there any chance of getting either of these two things into 2.2.21?

Mike
