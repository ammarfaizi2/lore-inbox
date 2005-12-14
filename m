Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965051AbVLNWrp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965051AbVLNWrp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Dec 2005 17:47:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbVLNWrp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Dec 2005 17:47:45 -0500
Received: from fmr23.intel.com ([143.183.121.15]:51843 "EHLO
	scsfmr003.sc.intel.com") by vger.kernel.org with ESMTP
	id S965051AbVLNWro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Dec 2005 17:47:44 -0500
Date: Wed, 14 Dec 2005 14:47:28 -0800
From: Rajesh Shah <rajesh.shah@intel.com>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: Andrew Morton <akpm@osdl.org>, ashutosh.naik@gmail.com,
       linux-kernel@vger.kernel.org, greg@kroah.com
Subject: Re: [BUG] Early Kernel Panic with 2.6.15-rc5
Message-ID: <20051214144728.A32611@unix-os.sc.intel.com>
Reply-To: Rajesh Shah <rajesh.shah@intel.com>
References: <81083a450512102211r608cee8wc16cc19565a1488f@mail.gmail.com> <20051210223453.24f7515b.akpm@osdl.org> <20051211095506.176a26ae.rdunlap@xenotime.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20051211095506.176a26ae.rdunlap@xenotime.net>; from rdunlap@xenotime.net on Sun, Dec 11, 2005 at 09:55:06AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 11, 2005 at 09:55:06AM -0800, Randy.Dunlap wrote:
> On Sat, 10 Dec 2005 22:34:53 -0800 Andrew Morton wrote:
> 
> 
> I reported this about 2 weeks ago.  Rajesh (iirc) says that it's a
> timing issue and he is reworking some of the init code...
> (like Greg said, it won't be fixed real quickly).
> 
Actually, this is already fixed here:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113434648617851&w=2

I believe Greg has already picked up this patch.

thanks,
Rajesh
