Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262560AbTJJHao (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 03:30:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262583AbTJJHao
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 03:30:44 -0400
Received: from fgwmail5.fujitsu.co.jp ([192.51.44.35]:32978 "EHLO
	fgwmail5.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S262560AbTJJHal (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 03:30:41 -0400
Date: Fri, 10 Oct 2003 16:30:27 +0900
From: YoshiyaETO <eto@soft.fujitsu.com>
Subject: Re: 2.7 thoughts
To: William Lee Irwin III <wli@holomorphy.com>,
       Stuart Longland <stuartl@longlandclan.hopto.org>,
       linux-kernel@vger.kernel.org
Cc: Stephan von Krawczynski <skraw@ithnet.com>, lgb@lgb.hu,
       Fabian.Frederick@prov-liege.be
Message-id: <047b01c38f00$60b34840$6a647c0a@eto>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
Content-type: text/plain;	charset="iso-8859-1"
Content-transfer-encoding: 7bit
X-Priority: 3
X-MSMail-priority: Normal
References: <D9B4591FDBACD411B01E00508BB33C1B01F13BCE@mesadm.epl.prov-liege.be>
 <20031009115809.GE8370@vega.digitel2002.hu>
 <20031009165723.43ae9cb5.skraw@ithnet.com>
 <3F864F82.4050509@longlandclan.hopto.org> <20031010063039.GA700@holomorphy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
> > * hotplug motherboard & entire computer too I spose ;-)
>
> Um, this is worse than the above wrt. being too vague.
----
"Hotplug node" is a better explanation, I think.
"Node" includes CPUs and/or Memory and/or some kind of IOs.
And "Node" should be flexibly configurable also.

----- Original Message ----- 
From: "William Lee Irwin III" <wli@holomorphy.com>
To: "Stuart Longland" <stuartl@longlandclan.hopto.org>
Cc: "Stephan von Krawczynski" <skraw@ithnet.com>; <lgb@lgb.hu>;
<Fabian.Frederick@prov-liege.be>; <linux-kernel@vger.kernel.org>
Sent: Friday, October 10, 2003 3:30 PM
Subject: Re: 2.7 thoughts


> On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
> Stephan von Krawczynski wrote:
> >>* hotplug CPU
> >>* hotplug RAM
>
> Generally thought of as desirable, but hotplug RAM needs a *LOT* of
> qualification.
>
>
> On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
> > * hotplug motherboard & entire computer too I spose ;-)
>
> Um, this is worse than the above wrt. being too vague.
>
>
> On Fri, Oct 10, 2003 at 04:19:46PM +1000, Stuart Longland wrote:
> > Although sarcasm aside, a couple of ideas that have been bantered around
> > on this list (and a few of my own ideas):
> > - /proc interface alternative to modutils/module-init-tools.
> > That is, to have a directory of virtual nodes in /proc
> > to provide the functionality of insmod, rmmod, lsmod &
> > modprobe would be great -- especially from the viewpoint
> > of recue disk images, etc.
>
> No way in Hell.
>
>
> -- wli
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

