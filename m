Return-Path: <linux-kernel-owner+w=401wt.eu-S1751281AbWLLMqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751281AbWLLMqh (ORCPT <rfc822;w@1wt.eu>);
	Tue, 12 Dec 2006 07:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751282AbWLLMqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Dec 2006 07:46:37 -0500
Received: from smtp21.orange.fr ([80.12.242.46]:20090 "EHLO smtp21.orange.fr"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751281AbWLLMqg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Dec 2006 07:46:36 -0500
X-ME-UUID: 20061212124635543.849BF1C0009F@mwinf2129.orange.fr
Subject: Re: Nokia E61 and the kernel BUG at mm/slab.c:594
From: Xavier Bestel <xavier.bestel@free.fr>
To: Oliver Neukum <oliver@neukum.org>
Cc: Thomas Sailer <t.sailer@alumni.ethz.ch>, Joscha Ihl <joscha@grundfarm.de>,
       linux-kernel@vger.kernel.org, ihl@fh-brandenburg.de,
       Muli Ben-Yehuda <muli@il.ibm.com>
In-Reply-To: <200612121216.10902.oliver@neukum.org>
References: <20061211173506.5c8cb479@localhost>
	 <20061212094421.GC2818@rhun.haifa.ibm.com>
	 <1165919321.4066.44.camel@playstation2.hb9jnx.ampr.org>
	 <200612121216.10902.oliver@neukum.org>
Content-Type: text/plain
Date: Tue, 12 Dec 2006 13:46:28 +0100
Message-Id: <1165927588.952.22.camel@frg-rhel40-em64t-03>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-27) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-12-12 at 12:16 +0100, Oliver Neukum wrote:
> Am Dienstag, 12. Dezember 2006 11:28 schrieben Sie:
> > On Tue, 2006-12-12 at 11:44 +0200, Muli Ben-Yehuda wrote:
> > 
> > > I assume the previous crash was 2.6.19 with SMP? did it work with
> > > earlier kernels?
> > 
> > It happens to me as well, current Fedora 6 update
> > kernel-2.6.18-1.2849.fc6.i686 UP, with a Nokia E70 in "PC Suite" mode.
> 
> What functions does this mode involve?

Something like OBEX-over-USB

	Xav

