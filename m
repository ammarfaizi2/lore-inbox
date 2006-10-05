Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWJEShs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWJEShs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 14:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750776AbWJEShs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 14:37:48 -0400
Received: from ra.tuxdriver.com ([70.61.120.52]:4624 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1750769AbWJEShs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 14:37:48 -0400
Date: Thu, 5 Oct 2006 14:36:51 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: andersen@codepoet.org, Jeff Garzik <jeff@garzik.org>,
       linux-kernel@vger.kernel.org
Subject: Re: wpa supplicant/ipw3945, ESSID last char missing
Message-ID: <20061005183645.GD18408@tuxdriver.com>
References: <20061003180543.GD23912@tuxdriver.com> <4522A9BE.9000805@garzik.org> <20061003183849.GA17635@bougret.hpl.hp.com> <4522B311.7070905@garzik.org> <20061003214038.GE23912@tuxdriver.com> <20061003231648.GB26351@thunk.org> <1159948179.2817.26.camel@ux156> <20061005163513.GC6510@bougret.hpl.hp.com> <4525364D.1000409@garzik.org> <20061005174241.GA23632@codepoet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061005174241.GA23632@codepoet.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 11:42:41AM -0600, Erik Andersen wrote:
> On Thu Oct 05, 2006 at 12:43:57PM -0400, Jeff Garzik wrote:
> > Wireless Extensions has reached end-of-life, and so we only need to
> > support what's out there in wide distribution.
> 
> Hmm, so what is going to replace it?  I was messing about with my
> old powerbook G4 titanium, trying to make wpa_supplicant work
> when I realized the airport/orinoco driver used for my powerbook
> can't handle WPA since that apparently requires at least WE-18.
> I started looking into what it would take to teach the orinoco
> driver about WE>=18.  But I suppose there is no point in my
> looking further if WE is heading to the great bit-bucket in the
> sky.

Driver fixes to support later WE versions are still welcome.
Information on supporting WPA for that driver will still be needed
for cfg80211.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
