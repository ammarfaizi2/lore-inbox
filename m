Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132668AbRDOOU0>; Sun, 15 Apr 2001 10:20:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132664AbRDOOUR>; Sun, 15 Apr 2001 10:20:17 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:62729 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S132668AbRDOOUI>;
	Sun, 15 Apr 2001 10:20:08 -0400
Date: Sun, 15 Apr 2001 16:20:01 +0200
From: Jens Axboe <axboe@suse.de>
To: cacook@freedom.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Writing to Pana DVD-RAM
Message-ID: <20010415162001.E1982@suse.de>
In-Reply-To: <20010414213259Z132548-682+222@vger.kernel.org> <3AD8CC04.EA5022C1@coplanar.net> <20010415135500Z132658-682+339@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010415135500Z132658-682+339@vger.kernel.org>; from cacook@freedom.net on Sun, Apr 15, 2001 at 07:53:22AM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 15 2001, cacook@freedom.net wrote:
> DOH!  You're right.
> 
> I can now write to it, but only get one chance.  Copy a file to
> DVDRAM, read, print, etc, but when I try to rm or mv, segfault.
> Foreverafter the DVDRAM is 'busy'.  Cannot umount.  Must reboot then
> umount.  Remount, get another write, but on subsequent write,
> segfault.

Please decode that oops and send it along, see REPORTING-BUGS

-- 
Jens Axboe

