Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261887AbVCCP7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261887AbVCCP7T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 10:59:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261755AbVCCP7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 10:59:19 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:24567 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261887AbVCCP7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 10:59:17 -0500
Message-ID: <42273426.7030509@nortel.com>
Date: Thu, 03 Mar 2005 09:58:30 -0600
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040115
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@pobox.com>
CC: "David S. Miller" <davem@davemloft.net>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: RFD: Kernel release numbering
References: <Pine.LNX.4.58.0503021340520.25732@ppc970.osdl.org>	<42264F6C.8030508@pobox.com>	<20050302162312.06e22e70.akpm@osdl.org>	<42265A6F.8030609@pobox.com>	<20050302165830.0a74b85c.davem@davemloft.net>	<422674A4.9080209@pobox.com>	<Pine.LNX.4.58.0503021932530.25732@ppc970.osdl.org>	<42268749.4010504@pobox.com> <20050302200214.3e4f0015.davem@davemloft.net> <42268F93.6060504@pobox.com> <4226969E.5020101@pobox.com>
In-Reply-To: <4226969E.5020101@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> If Linus/DaveM really don't like -pre/-rc naming, I think 2.6.x.y is 
> preferable to even/odd.
> 
> Just create a 2.6.X repo at each release.  For bug fixes to 2.6.X, 
> commit to this repo, then pull into linux-2.6.  For everything else, 
> pull straight into linux-2.6.

For what it's worth, I'd like to add a vote in support of this.  I like 
the idea of bugfixes being applied to previous versions (until the next 
stable one comes out, say).

Chris
