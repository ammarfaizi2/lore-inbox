Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261601AbTISPVa (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 11:21:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTISPVa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 11:21:30 -0400
Received: from zok.SGI.COM ([204.94.215.101]:50088 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261601AbTISPV3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 11:21:29 -0400
Date: Fri, 19 Sep 2003 08:21:18 -0700
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Andrew Morton <akpm@osdl.org>, pfg@sgi.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Altix console driver
Message-ID: <20030919152118.GA2121@sgi.com>
Mail-Followup-To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Andrew Morton <akpm@osdl.org>, pfg@sgi.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20030917222414.GA25931@sgi.com> <20030917152139.42a1ce20.akpm@osdl.org> <1063886970.15957.13.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063886970.15957.13.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, according to the FSF our extra clauses are compatible with the GPL
and LGPL.  See http://oss.sgi.com/projects/GenInfo/NoticeExplan/.  If
you still disagree then we'll have to try to find another solution.

Thanks,
Jesse

On Thu, Sep 18, 2003 at 01:09:31PM +0100, Alan Cox wrote:
> On Mer, 2003-09-17 at 23:21, Andrew Morton wrote:
> 
> > Would it be more appropriate to place this under arch/ia64?
> 
> Unless they clarify the GPL violating license clause I'd suggest
> strongly it goes into /dev/null. The GPL states:
> 
> 
>   6. Each time you redistribute the Program (or any work based on the
> Program), the recipient automatically receives a license from the
> original licensor to copy, distribute or modify the Program subject to
> these terms and conditions.  You may not impose any further
> restrictions on the recipients' exercise of the rights granted herein.
> You are not responsible for enforcing compliance by third parties to
> this License.
> 
> I am perfectly permitted by the GPL to modify Linux and add other code
> to it, or to create a new product based on it that is GPL licensed. 
> 
> 
> SGI need to fix their boilerplate. I can kind of guess what they are
> trying to say but it needs tweaking.
