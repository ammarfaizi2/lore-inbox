Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263875AbUCPKMD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 05:12:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263872AbUCPKLs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 05:11:48 -0500
Received: from gprs214-17.eurotel.cz ([160.218.214.17]:61059 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S263743AbUCPKLp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 05:11:45 -0500
Date: Tue, 16 Mar 2004 11:11:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Romano Giannetti <romano@dea.icai.upco.es>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Patrick Mochel <mochel@osdl.org>
Subject: Re: Remove pmdisk from kernel
Message-ID: <20040316101134.GB2177@elf.ucw.cz>
References: <20040315195440.GA1312@elf.ucw.cz> <20040315125357.3330c8c4.akpm@osdl.org> <20040315205752.GG258@elf.ucw.cz> <20040316091648.GB6301@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040316091648.GB6301@pern.dea.icai.upco.es>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Út 16-03-04 10:16:48, Romano Giannetti wrote:
> On Mon, Mar 15, 2004 at 09:57:52PM +0100, Pavel Machek wrote:
> > Hi!
> > > Pavel Machek <pavel@ucw.cz> wrote:
> > > >
> > > > This removes pmdisk from kernel.
> > > 
> 
> Are you sure swsusp is equivalent? Last time I tried (2.6.1, I am in serious
> time shortage in this period) swsusp did not work on my Vaio fx-701, while
> PMDISK yes (ACPI enabled). I will try to test again in this weekend. 

Yes, I'm pretty sure. There may be some bug in both of them, but they
do the same thing. (And swsusp should have slightly lower ammount of
bugs).
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
