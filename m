Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267250AbUH1Pgb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267250AbUH1Pgb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 Aug 2004 11:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267259AbUH1Pgb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 Aug 2004 11:36:31 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:48276 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S267250AbUH1PdS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 Aug 2004 11:33:18 -0400
Subject: Re: PWC issue
From: Kasper Sandberg <lkml@metanurb.dk>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Greg KH <greg@kroah.com>, adam@yggdrasil.com, steve@steve-parker.org,
       LKML Mailinglist <linux-kernel@vger.kernel.org>
In-Reply-To: <20040828081100.6b6c9f8c.rddunlap@osdl.org>
References: <200408281750.i7SHo5C05936@freya.yggdrasil.com>
	 <20040828051919.GC10151@kroah.com>
	 <20040828081100.6b6c9f8c.rddunlap@osdl.org>
Content-Type: text/plain
Date: Sat, 28 Aug 2004 17:33:16 +0200
Message-Id: <1093707197.12690.5.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 1.5.93 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-08-28 at 08:11 -0700, Randy.Dunlap wrote:
> On Fri, 27 Aug 2004 22:19:19 -0700 Greg KH wrote:
> 
> | On Sat, Aug 28, 2004 at 10:50:05AM -0700, Adam J. Richter wrote:
> | > 
> | > 	By the way, I have a long running dispute with Greg K-H
> | > about his refusal so far to remove replace the GPL incompatible
> | > firmware in certain USB serial drivers with such a user level
> | > loading mechanism.  Go figure.
> | 
> | Send me a patch to do so, and I will apply it (must include userspace
> | files so that hotplug can load them properly.)
> | 
> | The last time we went around about this I rejected it as we were in a
> | stable kernel series.  As that is now not true, I'm open to the patch.
> 
> Which part is now not true?
i believe what he means is, that the new development model permits doing
such stuff even now where 2.6 is a stable release
> 
> | It's not an idealogical issue for me, given Linus's statements about
> | firmware in the kernel, but I do agree that it is a better thing as we
> | have used up less kernel memory.
> 
> 
> --
> ~Randy
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

