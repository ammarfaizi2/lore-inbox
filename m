Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267540AbRGMVJ3>; Fri, 13 Jul 2001 17:09:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267544AbRGMVJR>; Fri, 13 Jul 2001 17:09:17 -0400
Received: from weta.f00f.org ([203.167.249.89]:14979 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267539AbRGMVJE>;
	Fri, 13 Jul 2001 17:09:04 -0400
Date: Sat, 14 Jul 2001 09:09:05 +1200
From: Chris Wedgwood <cw@f00f.org>
To: lyons@pobox.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: ioctl bug?
Message-ID: <20010714090905.C5737@weta.f00f.org>
In-Reply-To: <Pine.LNX.4.33.0107131559160.12456-100000@gruel.uchicago.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0107131559160.12456-100000@gruel.uchicago.edu>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 13, 2001 at 04:00:24PM -0500, Gary Lyons wrote:

    Yes. sorry about leaving that out.

strace -fblah lsattr some-dir/

(where some-dir is empty)

and then show us what 'blah' looks like



   --cw
