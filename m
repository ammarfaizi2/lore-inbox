Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266585AbUBDW3i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 17:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266621AbUBDW3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 17:29:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:33002 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266585AbUBDW3a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 17:29:30 -0500
Date: Wed, 4 Feb 2004 22:29:21 +0000
From: Matthew Wilcox <willy@debian.org>
To: Steve Kenton <skenton@ou.edu>
Cc: rth@twiddle.net, rmk@arm.linux.org.uk, spyro@f2s.com, bjornw@axis.com,
       ysato@users.sourceforge.jp, Linux Kernel <linux-kernel@vger.kernel.org>,
       davidm@hpl.hp.com, jes@trained-monkey.org, ralf@gnu.org, matthew@wil.cx,
       paulus@samba.org, schwidefsky@de.ibm.com, gniibe@m17n.org,
       wesolows@foobazco.org, davem@redhat.com, jdike@karaya.com,
       uclinux-v850@lsi.nec.co.jp, ak@suse.de
Subject: Re: 2.6.2 make defconfig for all arches give 171 "trying to assign nonexistent symbol" errors
Message-ID: <20040204222921.GA24334@parcelfarce.linux.theplanet.co.uk>
References: <40216DEE.6040306@ou.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40216DEE.6040306@ou.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 04, 2004 at 04:10:54PM -0600, Steve Kenton wrote:
> 2.6.2 make defconfig for all arches give 171 "trying to assign nonexistent 
> symbol" errors
> total in 13 different arches, up from 143 in 2.6.1.

why does this matter?  if you want to work on Kconfig stuff, I have some
things you can do that will actually help ;-)

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
