Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266974AbRGMVNV>; Fri, 13 Jul 2001 17:13:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266973AbRGMVNJ>; Fri, 13 Jul 2001 17:13:09 -0400
Received: from weta.f00f.org ([203.167.249.89]:15235 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S266974AbRGMVMs>;
	Fri, 13 Jul 2001 17:12:48 -0400
Date: Sat, 14 Jul 2001 09:12:49 +1200
From: Chris Wedgwood <cw@f00f.org>
To: lyons@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl bug?
Message-ID: <20010714091249.D5737@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107131559160.12456-100000@gruel.uchicago.edu> <20010714090905.C5737@weta.f00f.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010714090905.C5737@weta.f00f.org>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 14, 2001 at 09:09:05AM +1200, Chris Wedgwood wrote:
    On Fri, Jul 13, 2001 at 04:00:24PM -0500, Gary Lyons wrote:
    
        Yes. sorry about leaving that out.
    
    strace -fblah lsattr some-dir/
    
    (where some-dir is empty)

actually, make sure at least one file is in there


  --cw
