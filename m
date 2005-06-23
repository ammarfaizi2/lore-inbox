Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262314AbVFWGTC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262314AbVFWGTC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 02:19:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262312AbVFWGTB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 02:19:01 -0400
Received: from poros.telenet-ops.be ([195.130.132.44]:49313 "EHLO
	poros.telenet-ops.be") by vger.kernel.org with ESMTP
	id S262223AbVFWGOz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 02:14:55 -0400
Subject: Re: [Ebtables-devel] Re: 2.6.12: connection tracking broken?
From: Bart De Schuymer <bdschuym@pandora.be>
To: Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
       Patrick McHardy <kaber@trash.net>,
       Bart De Schuymer <bdschuym@telenet.be>, netfilter-devel@manty.net,
       netfilter-devel@lists.netfilter.org, linux-kernel@vger.kernel.org,
       ebtables-devel@lists.sourceforge.net, rankincj@yahoo.com
In-Reply-To: <42B9FC19.2000604@gmx.net>
References: <E1Dk9nK-0001ww-00@gondolin.me.apana.org.au>
	 <Pine.LNX.4.62.0506200432100.31737@kaber.coreworks.de>
	 <1119249575.3387.3.camel@localhost.localdomain>	<42B6B373.20507@trash.net>
	 <1119293193.3381.9.camel@localhost.localdomain>
	 <42B74FC5.3070404@trash.net>
	 <1119338382.3390.24.camel@localhost.localdomain>
	 <42B82F35.3040909@trash.net> <20050622214920.GA13519@gondor.apana.org.au>
	 <42B9FC19.2000604@gmx.net>
Content-Type: text/plain
Date: Thu, 23 Jun 2005 06:27:49 +0000
Message-Id: <1119508069.3387.20.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Op do, 23-06-2005 te 02:02 +0200, schreef Carl-Daniel Hailfinger:
> For my local setup it is already a minor PITA that there is no tool
> combining the functionality of arptables, ebtables and iptables, but
> I can cope with the help of marking and ipt_physdev. If that doesn't
> work reliably anymore, I'll be stuck.
> 
> Wasn't someone working on a unified framework for *tables? IIRC that
> would have been pkttables, but Harald(?) said there was not much
> code there yet.

On my todo list is making the arptables matches usable in ebtables
rules. I think it would be very nice if {eb,ip,ip6,arp}tables modules
could be used together.

cheers,
Bart


