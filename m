Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271211AbTHCRLz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 13:11:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271222AbTHCRLz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 13:11:55 -0400
Received: from village.ehouse.ru ([193.111.92.18]:26383 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S271211AbTHCRLx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 13:11:53 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.22pre6aa1
Date: Sun, 3 Aug 2003 21:12:00 +0400
User-Agent: KMail/1.5
Cc: linux-kernel@vger.kernel.org
References: <200307231521.15897.rathamahata@php4.ru> <200307251510.59062.rathamahata@php4.ru> <20030725190220.GD2659@x30.random>
In-Reply-To: <20030725190220.GD2659@x30.random>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308032112.00185.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Friday 25 July 2003 23:02, Andrea Arcangeli wrote:
> Hi Sergey,
>
> On Fri, Jul 25, 2003 at 03:10:59PM +0400, Sergey S. Kostyliov wrote:
> > I doubt it depends on bigpages because they
> > are not used in my setup. But I can live with that. Rule: do not run
> > `swapoff -a` under load doesn't sound as impossible in my case (if this
> > is the only way to trigger this problem).
>
> can you reproduce it with 2.4.21rc8aa1? If not, then likely it's a
> 2.5/2.6 bug that went in 2.4 during the backport. I spoke with Hugh an
> hour ago about this, he will soon look into this too.

Sorry for late responce. I wasn't able to reproduce neither oops nor
lockup with 2.4.21rc8aa1.

>
> Andrea

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
