Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262038AbTHTP2U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 11:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262037AbTHTP2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 11:28:20 -0400
Received: from mail.cyberus.ca ([209.195.118.111]:40710 "EHLO mail.cyberus.ca")
	by vger.kernel.org with ESMTP id S262036AbTHTP2S (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 11:28:18 -0400
Subject: RE: [2.4 PATCH] bugfix: ARP respond on all devices
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: Richard Underwood <richard@aspectgroup.co.uk>
Cc: "'David S. Miller'" <davem@redhat.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, skraw@ithnet.com, willy@w.ods.org,
       carlosev@newipnet.com, lamont@scriptkiddie.org, davidsen@tmr.com,
       bloemsaa@xs4all.nl, marcelo@conectiva.com.br, netdev@oss.sgi.com,
       linux-net@vger.kernel.org, layes@loran.com, torvalds@osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <1061393011.1029.51.camel@jzny.localdomain>
References: <353568DCBAE06148B70767C1B1A93E625EAB61@post.pc.aspectgroup.co.uk>
	 <1061393011.1029.51.camel@jzny.localdomain>
Content-Type: text/plain
Organization: jamalopolis
Message-Id: <1061393295.1030.54.camel@jzny.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 
Date: 20 Aug 2003 11:28:15 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 11:23, jamal wrote:
> What Dave meant is the state machine used in 2461 for IPV6 is actually
> used in v4 as well. 

I should have said in linux - dont think in any BSD derived OSes.
To be specific look at the neighbor code.

cheers,
jamal


