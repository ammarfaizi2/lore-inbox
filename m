Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267410AbUIOUo5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267410AbUIOUo5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 16:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267409AbUIOUnY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 16:43:24 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:19587 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267410AbUIOUmG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 16:42:06 -0400
Message-ID: <4148A90F.80003@pobox.com>
Date: Wed, 15 Sep 2004 16:41:51 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Paul Jakma <paul@clubi.ie>, Netdev <netdev@oss.sgi.com>,
       leonid.grossman@s2io.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: The ultimate TOE design
References: <4148991B.9050200@pobox.com>	 <Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org> <1095275660.20569.0.camel@localhost.localdomain>
In-Reply-To: <1095275660.20569.0.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Mer, 2004-09-15 at 21:04, Paul Jakma wrote:
> 
>>The intel IXP's are like the above, XScale+extra-bits host-on-a-PCI 
>>card running Linux. Or is that what you were referring to with 
>>"<cards exist> but they are all fairly expensive."?
> 
> 
> Last time I checked 2Ghz accelerators for intel and AMD were quite cheap
> and also had the advantage they ran user mode code when idle from
> network processing.


The point was more to show people who are doing TOE _anyway_ to a decent 
design.

As I said in another post, "just don't bother with TOE" is a very valid 
answer with today's CPUs.

	Jeff


