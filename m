Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263664AbUJNMLv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263664AbUJNMLv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 08:11:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263743AbUJNMLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 08:11:51 -0400
Received: from [213.146.154.40] ([213.146.154.40]:22208 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263664AbUJNMLt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 08:11:49 -0400
Subject: Re: Fw: signed kernel modules?
From: David Woodhouse <dwmw2@infradead.org>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: David Howells <dhowells@redhat.com>,
       "Rusty Russell (IBM)" <rusty@au1.ibm.com>, Greg KH <greg@kroah.com>,
       Arjan van de Ven <arjanv@redhat.com>, Joy Latten <latten@us.ibm.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.61.0410141357380.877@scrub.home>
References: <Pine.LNX.4.61.0410132346080.7182@scrub.home>
	 <1097626296.4013.34.camel@localhost.localdomain>
	 <1096411448.3230.22.camel@localhost.localdomain>
	 <1092403984.29463.11.camel@bach> <1092369784.25194.225.camel@bach>
	 <20040812092029.GA30255@devserv.devel.redhat.com>
	 <20040811211719.GD21894@kroah.com>
	 <OF4B7132F5.8BE9D947-ON87256EEB.007192D0-86256EEB.00740B23@us.ibm.com>
	 <1092097278.20335.51.camel@bach> <20040810002741.GA7764@kroah.com>
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
Content-Type: text/plain
Message-Id: <1097755890.318.700.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Thu, 14 Oct 2004 13:11:31 +0100
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
X-SRS-Rewrite: SMTP reverse-path rewritten from <dwmw2@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-10-14 at 14:01 +0200, Roman Zippel wrote:
> If you don't trust insmod, how can you trust the build system?

How are they related? If you don't trust the _build_ system on which the
kernel and modules were compiled and signed, the whole game is lost
anyway.

Insmod is running on the live system, and has nothing to do with the
build system.

-- 
dwmw2

