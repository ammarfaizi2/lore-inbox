Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266063AbUFDXOy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266063AbUFDXOy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Jun 2004 19:14:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266061AbUFDXOJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Jun 2004 19:14:09 -0400
Received: from mail.kroah.org ([65.200.24.183]:467 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S266070AbUFDXJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Jun 2004 19:09:04 -0400
Date: Fri, 4 Jun 2004 16:07:56 -0700
From: Greg KH <greg@kroah.com>
To: Andy Lutomirski <luto@myrealbox.com>
Cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-rc2-bk4: empty-named directory in /sys
Message-ID: <20040604230754.GA14330@kroah.com>
References: <fa.damn9ec.1n4co3u@ifi.uio.no> <fa.nssco73.187q0r9@ifi.uio.no> <40C0E66B.3020509@myrealbox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40C0E66B.3020509@myrealbox.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 04, 2004 at 02:15:23PM -0700, Andy Lutomirski wrote:
> Denis Vlasenko wrote:
> 
> >On Friday 04 June 2004 23:26, Greg KH wrote:
> >
> >>Hm, is the hostap code in the main kernel tree now?  That's the only
> >>thing odd that I see from your messages.  Does this happen with
> >>2.6.7-rc2 with no extra patches?
> 
> This happens in 2.6.7-rc1-mm1 too, both with and without hostap (I just 
> tried it).

Again, how about a clean Linus tree?

I can't seem to duplicate it here with his tree...

thanks,

greg k-h
