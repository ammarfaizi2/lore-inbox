Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293740AbSCGWB6>; Thu, 7 Mar 2002 17:01:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310210AbSCGWBt>; Thu, 7 Mar 2002 17:01:49 -0500
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:22006
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id <S293714AbSCGWBd>; Thu, 7 Mar 2002 17:01:33 -0500
Date: Thu, 7 Mar 2002 14:01:59 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: Linux 2.4.19pre2-ac3
Message-ID: <20020307220159.GC28141@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <E16iyh2-0002OY-00@the-village.bc.nu> <20020307172806.GA28141@matchmail.com> <20020307204526.GG28744@stingr.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307204526.GG28744@stingr.net>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 11:45:26PM +0300, Paul P Komkoff Jr wrote:
> Replying to Mike Fedyk:
> > > o	Fix quota deadlock and extreme load corruption	(Jan Kara, Chris Mason)
> > 
> > Corruption of what?  Quota meta-data?
> 
> Maybe - I've got  weird quota entries about same uid on same filesystem with
> -pre2-ac2. But this was patched by me to add reiserfs quota so I thought
> that was my fault :)

I have an affirmative responce from Alan, so it's just quota meta-data.
