Return-Path: <linux-kernel-owner+w=401wt.eu-S1161080AbXAEMOA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161080AbXAEMOA (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 07:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965144AbXAEMOA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 07:14:00 -0500
Received: from aa012msr.fastwebnet.it ([85.18.95.72]:58963 "EHLO
	aa012msr.fastwebnet.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965101AbXAEMN6 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 07:13:58 -0500
Date: Fri, 5 Jan 2007 13:13:10 +0100
From: Mattia Dongili <malattia@linux.it>
To: Stelian Pop <stelian@popies.net>
Cc: Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ismail Donmez <ismail@pardus.org.tr>, Andrea Gelmini <gelma@gelma.net>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       Cacy Rodney <cacy-rodney-cacy@tlen.pl>
Subject: Re: sonypc with Sony Vaio VGN-SZ1VP
Message-ID: <20070105121310.GB13533@inferi.kami.home>
Mail-Followup-To: Stelian Pop <stelian@popies.net>,
	Len Brown <lenb@kernel.org>, Andrew Morton <akpm@osdl.org>,
	Ismail Donmez <ismail@pardus.org.tr>,
	Andrea Gelmini <gelma@gelma.net>, linux-kernel@vger.kernel.org,
	linux-acpi@vger.kernel.org, Cacy Rodney <cacy-rodney-cacy@tlen.pl>
References: <49814.213.30.172.234.1159357906.squirrel@webmail.popies.net> <200701040024.29793.lenb@kernel.org> <1167905384.7763.36.camel@localhost.localdomain> <20070104191512.GC25619@inferi.kami.home> <1167991323.8985.23.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <1167991323.8985.23.camel@localhost.localdomain>
X-Message-Flag: Cranky? Try Free Software instead!
X-Operating-System: Linux 2.6.20-rc2-mm1-1 i686
X-Editor: Vim http://www.vim.org/
X-Disclaimer: Buh!
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 05, 2007 at 11:02:03AM +0100, Stelian Pop wrote:
> Le jeudi 04 janvier 2007 à 20:15 +0100, Mattia Dongili a écrit :
> 
> > > > What needs to happen is
> > > > 1. a maintainer for sony_acpi.c needs to step forward
> > > >     I can't do this, I'm not allowed to be in the reverse engineering business.
> > > 
> > > Well, I can't do this either, because I just don't have the required
> > > hardware anymore.
> > > 
> > > If someone want to step forward now it is a great time !
> > 
> > I have the hw and I'd be happy to do some basic working on the code
> 
> FYI, sonypi is also searching for a new maintainer, and it is quite
> closely related to sony_acpi...

Yes, probably the FnKeys stuff needs to worked out into a single driver
to ease it usage (I still remember some very old discussion about making
sonypi use the acpi methods to access the hw).

> If you are interested by the job, it is all yours. :)

Let's see if I can come up with something, I have also an ux50 that is
not very happy with current sonypi

Thanks
-- 
mattia
:wq!
