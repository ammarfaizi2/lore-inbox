Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313767AbSFJMkf>; Mon, 10 Jun 2002 08:40:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313628AbSFJMjl>; Mon, 10 Jun 2002 08:39:41 -0400
Received: from kweetal.tue.nl ([131.155.2.7]:59220 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S313743AbSFJMis>;
	Mon, 10 Jun 2002 08:38:48 -0400
Date: Mon, 10 Jun 2002 14:38:48 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Francois Gouget <fgouget@free.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jeremy White <jwhite@codeweavers.com>
Subject: Re: isofs unhide option:  troubles with Wine
Message-ID: <20020610123848.GA9393@win.tue.nl>
In-Reply-To: <Pine.LNX.4.43.0206091947390.6638-100000@amboise.dolphin> <Pine.LNX.4.44.0206100549330.6159-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 05:52:53AM -0600, Thunder from the hill wrote:

> On Sun, 9 Jun 2002, Francois Gouget wrote:
> > 2. or should it completely ignore the 'hidden' bit?
> 
> I already _had_ a patch which did exactly this.
> 
> Regards,
> Thunder

But your patch is too primitive, it affects both hidden and
associated files, while you only wanted to affect hidden files.
