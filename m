Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263171AbSJHNpc>; Tue, 8 Oct 2002 09:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263181AbSJHNpb>; Tue, 8 Oct 2002 09:45:31 -0400
Received: from employees.nextframe.net ([212.169.100.200]:37115 "EHLO
	sexything.nextframe.net") by vger.kernel.org with ESMTP
	id <S263171AbSJHNoY>; Tue, 8 Oct 2002 09:44:24 -0400
Date: Tue, 8 Oct 2002 15:57:48 +0200
From: Morten Helgesen <morten.helgesen@nextframe.net>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] ide tcq support, 2.5.40-bk
Message-ID: <20021008155748.A134@sexything>
Reply-To: morten.helgesen@nextframe.net
References: <20021007140054.GD1160@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021007140054.GD1160@suse.de>
User-Agent: Mutt/1.3.22.1i
X-Editor: VIM - Vi IMproved 6.0
X-Keyboard: PFU Happy Hacking Keyboard
X-Operating-System: Slackware Linux (of course)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, 

On Mon, Oct 07, 2002 at 04:00:54PM +0200, Jens Axboe wrote:
> Hi,
> 
> Tagged command queueing support for IDE is available again. It has a few
> rough edges from a source style POV, nothing that should impact
> stability though.
> 

[snip]

great work as usual - running it on 2.5.41. I`ve given it a good
beating on my old WD Experts, but haven`t met any problems yet.

I`d like this to go into mainline (again) - when Jens feels 
the time is right, of course.

== Morten

-- 

"Livet er ikke for nybegynnere" - sitat fra en klok person.

mvh
Morten Helgesen 
UNIX System Administrator & C Developer 
Nextframe AS
admin@nextframe.net / 93445641
http://www.nextframe.net
