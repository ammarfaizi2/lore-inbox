Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278128AbRJWRhd>; Tue, 23 Oct 2001 13:37:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278131AbRJWRhY>; Tue, 23 Oct 2001 13:37:24 -0400
Received: from c1313109-a.potlnd1.or.home.com ([65.0.121.190]:24328 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S278128AbRJWRhO>;
	Tue, 23 Oct 2001 13:37:14 -0400
Date: Tue, 23 Oct 2001 10:37:27 -0700
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org, coldsync-bugs@ooblick.com
Subject: Re: [OOPS] USB, Palm M500, Coldsync
Message-ID: <20011023103727.C9943@kroah.com>
In-Reply-To: <20011023191458.A4261@oisec.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011023191458.A4261@oisec.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.19 (i586)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 23, 2001 at 07:14:58PM +0200, Cliff Albert wrote:
> Hi,
> 
> Coldsync segfaults after a successful hotsync with my Palm M500 which
> is connected using the USB Cradle. It also generates a oops. I hope
> the following info is enough to fix this problem.

This isn't a coldsync bug :)

A number of other people have reported this problem, and it is on my
TODO list to fix.

Thanks for the oops trace.

greg k-h
