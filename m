Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291169AbSCSTHG>; Tue, 19 Mar 2002 14:07:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291279AbSCSTGz>; Tue, 19 Mar 2002 14:06:55 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:18672
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S291169AbSCSTGo>; Tue, 19 Mar 2002 14:06:44 -0500
Date: Tue, 19 Mar 2002 11:08:07 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: willy tarreau <wtarreau@yahoo.fr>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19pre3-ac2
Message-ID: <20020319190807.GV2254@matchmail.com>
Mail-Followup-To: willy tarreau <wtarreau@yahoo.fr>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020319185209.2308.qmail@web20505.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 19, 2002 at 07:52:09PM +0100, willy tarreau wrote:
> Hi Alan,
> 
> I cannot compile shm.c unless I apply this
> patch. I hope it's correct, I put 0 in the acct
> field just because there was 0 at the
> do_mmap() line.
> 
> I'm really sorry this patch will be mangled
> by my mail client here, but it's a one liner,
> self-explanatory.
> 

Hmm, Alan said in another post in this thread that it should be a "1".  I
wonder what'll happen with a "0" there instead...

Oh, your mailer fscked the patch.
