Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317650AbSGUHWq>; Sun, 21 Jul 2002 03:22:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317651AbSGUHWp>; Sun, 21 Jul 2002 03:22:45 -0400
Received: from adsl-66-136-199-175.dsl.austtx.swbell.net ([66.136.199.175]:20160
	"HELO digitalroadkill.net") by vger.kernel.org with SMTP
	id <S317650AbSGUHWp>; Sun, 21 Jul 2002 03:22:45 -0400
Subject: Re: [2.6] Most likely to be merged by Halloween... THE LIST
From: Austin Gonyou <austin@digitalroadkill.net>
To: Andi Kleen <ak@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <p731y9xva8m.fsf@oldwotan.suse.de>
References: <OF918E6F71.637B1CBC-ON85256BFB.004CDDD0@pok.ibm.com.suse.lists.linux.kernel>
	 <1027199147.16819.39.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel>
	 <p731y9xva8m.fsf@oldwotan.suse.de>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1027236213.29284.1.camel@UberGeek.digitalroadkill.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.1.0.99 (Preview Release)
Date: 21 Jul 2002 02:23:33 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-21 at 01:57, Andi Kleen wrote:
> Alan Cox <alan@lxorguk.ukuu.org.uk> writes:
> 
> > > o EVMS (Enterprise Volume Management System)      (EVMS team)
> > 
> > or LVM2, which already appears to be scrubbed down and clean
> 
> Is there any reason why not both can go in? As far as I know neither
> of them needs much of core changes, they are more like independent "drivers"
> of the generic block layer stacking interface. There are already multiple
> drivers of this - LVM and the various MD personalities.

I wholly agree. I had a couple of emails about my 2 cents..and
well..that's what it seems is the logical choice, but development time
to do such a thing seems to be the bottleneck, if there is one.

... 
> 
> -Andi
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Austin Gonyou <austin@digitalroadkill.net>
