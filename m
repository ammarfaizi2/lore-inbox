Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317024AbSFQVXJ>; Mon, 17 Jun 2002 17:23:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317026AbSFQVXI>; Mon, 17 Jun 2002 17:23:08 -0400
Received: from air-2.osdl.org ([65.172.181.6]:18817 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S317024AbSFQVXI>;
	Mon, 17 Jun 2002 17:23:08 -0400
Date: Mon, 17 Jun 2002 14:23:01 -0700
From: Bob Miller <rem@osdl.org>
To: Dave Jones <davej@suse.de>, Benjamin LaHaise <bcrl@redhat.com>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [patch] v2.5.22 - add wait queue function callback support
Message-ID: <20020617142301.B24347@doc.pdx.osdl.net>
References: <20020617161434.D1457@redhat.com> <20020617222812.I758@suse.de> <20020617135744.A24347@doc.pdx.osdl.net> <20020617230831.J758@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020617230831.J758@suse.de>; from davej@suse.de on Mon, Jun 17, 2002 at 11:08:32PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 17, 2002 at 11:08:32PM +0200, Dave Jones wrote:
> Your patch was to use wq_write_lock and friends in sched.c iirc.
> That change is now removed from my tree (though I've not put up a
> version containing that change yet).
> 
> Since 2.5.20 or so, the wq_write_lock functions are dead as in gone.
> Not around, Extinct. They are ex-functions.
> 
>         Dave

Always look before you leap.  Just looked a 2.5.20 kernel and these
are indeed gone.  Sorry for the fire drill.

-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
