Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266896AbUJNVaD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266896AbUJNVaD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 17:30:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266821AbUJNV3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 17:29:40 -0400
Received: from baythorne.infradead.org ([81.187.226.107]:31636 "EHLO
	baythorne.infradead.org") by vger.kernel.org with ESMTP
	id S266896AbUJNVZw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 17:25:52 -0400
Subject: Re: Fw: signed kernel modules?
From: David Woodhouse <dwmw2@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410142256360.877@scrub.home>
References: <Pine.LNX.4.61.0410132346080.7182@scrub.home>
	 <1097626296.4013.34.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <20040810002741.GA7764@kroah.com>
	 <1092189167.22236.67.camel@bach> <19388.1092301990@redhat.com>
	 <30797.1092308768@redhat.com>
	 <20040812111853.GB25950@devserv.devel.redhat.com>
	 <20040812200917.GD2952@kroah.com> <26280.1092388799@redhat.com>
	 <27175.1095936746@redhat.com> <30591.1096451074@redhat.com>
	 <10345.1097507482@redhat.com>
	 <1097507755.318.332.camel@hades.cambridge.redhat.com>
	 <1097534090.16153.7.camel@localhost.localdomain>
	 <1097570159.5788.1089.camel@baythorne.infradead.org>
	 <27277.1097702318@redhat.com> <16349.1097752349@redhat.com>
	 <Pine.LNX.4.61.0410141357380.877@scrub.home>
	 <1097755890.318.700.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.61.0410141554330.877@scrub.home>
	 <1097764251.318.724.camel@hades.cambridge.redhat.com>
	 <Pine.LNX.4.61.0410142256360.877@scrub.home>
Content-Type: text/plain
Message-Id: <1097789060.5788.2001.camel@baythorne.infradead.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 14 Oct 2004 22:24:20 +0100
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by baythorne.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 23:03 +0200, Roman Zippel wrote:
> Nice how you conclude from your habits to habits of other people, 

I'm one of the people who I suspect is _most_ likely to compile their
own kernel, and yet _still_ the majority of my boxen are running distro
kernels. It seemed like a relevant enough observation to me, in response
to your bizarre claim that 'most people compile kernel and modules on
the same machine'.

> but why did you ignore the rest of my mail? The primary topic of this
> was module signing not compile habits.

Because it didn't seem relevant. You joined a thread about module
signing asking "how to you want to win the whole game?" and saying "I'm
missing how this does fit into the big picture". Since I was only
discussing the technical details of _how_ we sign modules, I wasn't
really interested in such questions. 

If you _really_ need an answer then yes, I accept that module signing
won't achieve world peace all by itself. There, are you happy now? :)

-- 
dwmw2


