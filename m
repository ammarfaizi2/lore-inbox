Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267653AbUIOXqO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267653AbUIOXqO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Sep 2004 19:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267662AbUIOW1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Sep 2004 18:27:42 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38803 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267649AbUIOW06
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Sep 2004 18:26:58 -0400
Message-ID: <4148C1A2.2030309@pobox.com>
Date: Wed, 15 Sep 2004 18:26:42 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "David S. Miller" <davem@davemloft.net>
CC: alan@lxorguk.ukuu.org.uk, paul@clubi.ie, netdev@oss.sgi.com,
       leonid.grossman@s2io.com, linux-kernel@vger.kernel.org
Subject: Re: The ultimate TOE design
References: <4148991B.9050200@pobox.com>	<Pine.LNX.4.61.0409152102050.23011@fogarty.jakma.org>	<1095275660.20569.0.camel@localhost.localdomain>	<4148A90F.80003@pobox.com>	<20040915140123.14185ede.davem@davemloft.net>	<20040915210818.GA22649@havoc.gtf.org>	<20040915141346.5c5e5377.davem@davemloft.net>	<4148B2E5.50106@pobox.com> <20040915142926.7bc456a4.davem@davemloft.net>
In-Reply-To: <20040915142926.7bc456a4.davem@davemloft.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David S. Miller wrote:
> On Wed, 15 Sep 2004 17:23:49 -0400
> Jeff Garzik <jgarzik@pobox.com> wrote:
> 
> 
>>The typical definition of TOE is "offload 90+% of the net stack", as 
>>opposed to "TCP assist", which is stuff like TSO.
> 
> 
> I think a better goal is "offload 90+% of the net stack cost" which
> is effectively what TSO does on the send side.


A better goal is to not bother with TOE at all, and just get multi-core 
processors with huge memory bandwidth :)

Again, the point of my message is to have something _positive_ to tell 
people when they specifically asked about TOE.  Rather than "no, we'll 
never do TOE" we have "it's possible, but there are better questions you 
should be asking"

	Jeff


