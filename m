Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261756AbTDHVVb (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 17:21:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261764AbTDHVVb (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 17:21:31 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:6615 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261756AbTDHVVa (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 17:21:30 -0400
Date: Tue, 08 Apr 2003 15:32:45 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Robert Schiele <rschiele@uni-mannheim.de>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges (was:	[MAILER-DAEMON@rumms.uni-mannheim.de: Returned mail: see transcript for	details])
Message-ID: <3626620000.1049837565@aslan.btc.adaptec.com>
In-Reply-To: <1049833118.8939.0.camel@dhcp22.swansea.linux.org.uk>
References: <20030408071845.GA10002@schiele.local>	 <3566580000.1049834178@aslan.btc.adaptec.com>	 <20030408205136.GA8144@schiele.local> <1049833118.8939.0.camel@dhcp22.swansea.linux.org.uk>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Maw, 2003-04-08 at 21:51, Robert Schiele wrote:
>> Thanks for your note.  Hope you didn't feel offended.  At least this was not
>> my intention.  I just wanted to notify all people related to the affected
>> driver.
>> 
>> So it's up to the kernel tree maintainers to bring this fix into their trees.
> 
> Maintainers submit changes to the Linux kernel tree, not vice versa. Its
> push not pull

As far as the 2.4.X series is concerned, pushing has not helped.  I've
seen spelling fixes and incorrorct changes get accepted from non
maintainers "instantly", while the maintainers changes are not accepted.
Considering how long it took for the last set of driver changes to make
it from -ac into kernel.org, I just assumed that this strategy was
also failing.  Is that really the only way to get updates into Marcelo's
tree?

--
Justin

