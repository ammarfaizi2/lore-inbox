Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263031AbTC2Bxm>; Fri, 28 Mar 2003 20:53:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263079AbTC2Bxm>; Fri, 28 Mar 2003 20:53:42 -0500
Received: from cerebus.wirex.com ([65.102.14.138]:13816 "EHLO
	figure1.int.wirex.com") by vger.kernel.org with ESMTP
	id <S263031AbTC2Bxl>; Fri, 28 Mar 2003 20:53:41 -0500
Date: Fri, 28 Mar 2003 18:03:03 -0800
From: Chris Wright <chris@wirex.com>
To: Shaya Potter <spotter@yucs.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: process creation/deletions hooks
Message-ID: <20030328180303.A26128@figure1.int.wirex.com>
Mail-Followup-To: Shaya Potter <spotter@yucs.org>,
	linux-kernel@vger.kernel.org
References: <1048799290.31010.62.camel@zaphod>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1048799290.31010.62.camel@zaphod>; from spotter@yucs.org on Thu, Mar 27, 2003 at 04:08:10PM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Shaya Potter (spotter@yucs.org) wrote:
> 
> Would people be for/against an interface that allows for modules to
> register functions that can be called on process creation/deletion.  It
> would help us avoid the hacks, such as I described, and I imagine could
> have benefit others.

LSM provides hooks here already.  Take a look at lsm.immunix.org for
more info.

thanks,
-chris
-- 
Linux Security Modules     http://lsm.immunix.org     http://lsm.bkbits.net
