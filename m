Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266545AbUAWGys (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 01:54:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266541AbUAWGwX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 01:52:23 -0500
Received: from rth.ninka.net ([216.101.162.244]:48768 "EHLO rth.ninka.net")
	by vger.kernel.org with ESMTP id S266529AbUAWGtJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 01:49:09 -0500
Date: Thu, 22 Jan 2004 22:49:02 -0800
From: "David S. Miller" <davem@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: jw@pegasys.ws, linux-kernel@vger.kernel.org
Subject: Re: [OT] Confirmation Spam Blocking was: List 'linux-dvb' closed to
 public posts
Message-Id: <20040122224902.0f8aff9c.davem@redhat.com>
In-Reply-To: <Pine.LNX.4.58.0401221441500.2998@home.osdl.org>
References: <Pine.LNX.4.58.0401211155300.2123@home.osdl.org>
	<1074717499.18964.9.camel@localhost.localdomain>
	<20040121211550.GK9327@redhat.com>
	<20040121213027.GN23765@srv-lnx2600.matchmail.com>
	<pan.2004.01.21.23.40.00.181984@dungeon.inka.de>
	<1074731162.25704.10.camel@localhost.localdomain>
	<yq0hdyo15gt.fsf@wildopensource.com>
	<401000C1.9010901@blue-labs.org>
	<Pine.LNX.4.58.0401221034090.4548@dlang.diginsite.com>
	<40101B1E.3030908@blue-labs.org>
	<20040122221802.GD12666@pegasys.ws>
	<Pine.LNX.4.58.0401221441500.2998@home.osdl.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004 14:58:54 -0800 (PST)
Linus Torvalds <torvalds@osdl.org> wrote:

> Have you played with Markov chains? What happens is that you don't just
> build up a list of words and their likelihood of being spam or ham, you
> build up a list of word _combinations_ and the likelihood of one
> particular word following another one.
> 
> That's how a lot of the "random phrase" generators on the web work.
> 
> They can be absolutely hilarious, exactly because the sentences they
> generate actually _almost_ make sense. Sometimes you get an almost 
> readable story, but one that reads like somebody having a bad trip and his 
> reality just shifted 90 degrees. (Usually the best stories come if the 
> training material is coherent, which email sadly usually isn't).

This reminds me of the literary work done by William S. Burrough and his
infamous "cut ups".  Similar result for the reader.
