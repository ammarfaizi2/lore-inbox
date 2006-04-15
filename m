Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030249AbWDOPFN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030249AbWDOPFN (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 15 Apr 2006 11:05:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030272AbWDOPFN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 15 Apr 2006 11:05:13 -0400
Received: from ms-smtp-02.nyroc.rr.com ([24.24.2.56]:57482 "EHLO
	ms-smtp-02.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1030249AbWDOPFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 15 Apr 2006 11:05:11 -0400
Subject: Re: Direct writing to the IDE on panic?
From: Steven Rostedt <rostedt@goodmis.org>
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <20060414085227.83f73176.rdunlap@xenotime.net>
References: <1144936547.1336.20.camel@localhost.localdomain>
	 <1145024914.17531.21.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604141023240.11098@gandalf.stny.rr.com>
	 <1145026327.17531.24.camel@localhost.localdomain>
	 <Pine.LNX.4.58.0604141048260.11438@gandalf.stny.rr.com>
	 <20060414085227.83f73176.rdunlap@xenotime.net>
Content-Type: text/plain
Date: Sat, 15 Apr 2006 11:05:05 -0400
Message-Id: <1145113505.27407.40.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-04-14 at 08:52 -0700, Randy.Dunlap wrote:
> O
> Rusty Russell had an IDE block dump patch during the 2.4
> timeframe IIRC.  I don't know where it could be found now.
> Maybe in old LKCD tarballs or archives?

Hi Randy,

Thanks for the tip.  Is this what you are talking about?

http://marc.theaimsgroup.com/?l=linux-kernel&m=103217825112169&w=2


-- Steve


