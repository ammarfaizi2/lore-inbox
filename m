Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285692AbSCKSZQ>; Mon, 11 Mar 2002 13:25:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285424AbSCKSZI>; Mon, 11 Mar 2002 13:25:08 -0500
Received: from air-2.osdl.org ([65.201.151.6]:17793 "EHLO
	wookie-laptop.pdx.osdl.net") by vger.kernel.org with ESMTP
	id <S285720AbSCKSZB>; Mon, 11 Mar 2002 13:25:01 -0500
Subject: Re: 23 second kernel compile (aka which patches help scalibility on
	NUMA)
From: "Timothy D. Witham" <wookie@osdl.org>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: andersen@codepoet.org, linux-kernel@vger.kernel.org
In-Reply-To: <126403558.1015667602@[10.10.2.3]>
In-Reply-To: <20020309164305.GA2914@codepoet.org> 
	<126403558.1015667602@[10.10.2.3]>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 10:23:37 -0800
Message-Id: <1015871017.1276.48.camel@wookie-laptop.pdx.osdl.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  Ours is only a 16 way 500MHz machine but I do have 16 GB of memory
and we could stripe stuff across 80 disk drives. :-)

Tim

On Sat, 2002-03-09 at 09:53, Martin J. Bligh wrote:
> --On Saturday, March 09, 2002 9:43 AM -0700 Erik Andersen <andersen@codepoet.org> wrote:
> > On Fri Mar 08, 2002 at 09:47:04PM -0800, Martin J. Bligh wrote:
> >> "time make -j32 bzImage" is now down to 23 seconds.
> >> (16 way NUMA-Q, 700MHz P3's, 4Gb RAM).
> > [-----------snip---------]
> >> Any other suggestions are welcome. I'd also be interested
> > 
> > I suggest that you should give me your computer.  ;-) 
> 
> There's a very similar machine that's publicly available
> in the OSDL (http://www.osdlab.org). I don't think they'll
> let you take it home, but access is half way there ;-)
> 
> M.
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Timothy D. Witham - Lab Director - wookie@osdlab.org
Open Source Development Lab Inc - A non-profit corporation
15275 SW Koll Parkway - Suite H - Beaverton OR, 97006
(503)-626-2455 x11 (office)    (503)-702-2871     (cell)
(503)-626-2436     (fax)

