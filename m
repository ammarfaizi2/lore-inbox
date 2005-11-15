Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932239AbVKOBJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932239AbVKOBJw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Nov 2005 20:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751310AbVKOBJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Nov 2005 20:09:52 -0500
Received: from web50209.mail.yahoo.com ([206.190.38.50]:9559 "HELO
	web50209.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1751298AbVKOBJv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Nov 2005 20:09:51 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=W6bcd/gY0NN79Q6oqM/B9QxAq7WXyvdk6G3yosF4rPgfahmo2jgyTEL48bvG0XFXDH1XiFqQOGAHvJK8IbLBvvPcBLiZE/vv/jwO7WHIQDARzum2ZegpbEAn3M3YcQHXCC1rzIgr/bHW5zNA3pbid3ZK2q7AWKe2YG3O424GsdA=  ;
Message-ID: <20051115010951.54439.qmail@web50209.mail.yahoo.com>
Date: Mon, 14 Nov 2005 17:09:50 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: [2.6 patch] i386: always use 4k stacks
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131979779.5751.17.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

That doesn't answer my question. I want to know what __problems__
are caused by allowing the __choice__ of stack sizes.

-Alex


--- Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
> If we spent our entire lives waiting for people to fix code nothing
> would ever happen. Removing 8K stacks is a good thing to do for many
> reasons. The ndis wrapper people have known it is coming for a long
> time, and if it has a lot of users I'm sure someone in that community
> will take the time to make patches.
> 
> 


I code, therefore I am


		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
