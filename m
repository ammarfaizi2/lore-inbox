Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317380AbSGTGRo>; Sat, 20 Jul 2002 02:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317385AbSGTGRo>; Sat, 20 Jul 2002 02:17:44 -0400
Received: from loke.as.arizona.edu ([128.196.209.61]:6789 "EHLO
	loke.as.arizona.edu") by vger.kernel.org with ESMTP
	id <S317380AbSGTGRn>; Sat, 20 Jul 2002 02:17:43 -0400
Date: Fri, 19 Jul 2002 23:18:18 -0700 (MST)
From: Craig Kulesa <ckulesa@as.arizona.edu>
To: Greg KH <greg@kroah.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [USB] uhci-hcd oops on APM resume (2.5.23-26)
In-Reply-To: <20020719194326.GA23137@kroah.com>
Message-ID: <Pine.LNX.4.44.0207192306030.5859-100000@loke.as.arizona.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Greg,

Excellent.  The patch from Jan Harkes that you posted 
(http://www.cs.helsinki.fi/linux/linux-kernel/2002-28/1463.html)
worked wonderfully for me.  No more rogue USB disconnects on APM resume, 
and no more oopses. 

Any hopes for sending it Linus-ward? ;)

Many thanks!
Craig Kulesa

