Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262986AbTJ3X06 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Oct 2003 18:26:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263002AbTJ3X06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Oct 2003 18:26:58 -0500
Received: from portraits.wsisiz.edu.pl ([213.135.44.34]:33579 "EHLO
	portraits.wsisiz.edu.pl") by vger.kernel.org with ESMTP
	id S262986AbTJ3X05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Oct 2003 18:26:57 -0500
Date: Fri, 31 Oct 2003 00:26:37 +0100 (CET)
From: Lukasz Trabinski <lukasz@wsisiz.edu.pl>
To: chas williams <chas@cmf.nrl.navy.mil>
cc: linux-kernel@vger.kernel.org, Bartlomiej Solarz <solarz@wsisiz.edu.pl>
Subject: Re: Linux 2.4.23-pre8
In-Reply-To: <200310300030.h9U0U4NB001760@ginger.cmf.nrl.navy.mil>
Message-ID: <Pine.LNX.4.58LT.0310310022340.2673@lt.wsisiz.edu.pl>
References: <200310300030.h9U0U4NB001760@ginger.cmf.nrl.navy.mil>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 29 Oct 2003, chas williams wrote:

> this doesnt look bad. i see 1 tx packet and some rx packets.  how
> did you test this interface?  does tcpdump show anything?  could you
> be more specific about this configuration so i could try to duplicate
> your setup?  the nicstar driver seems to work for me in the 2.4.23-pre8
> kernel (ilmid, signalling).  i tested the clip module as well but that
> was via an arp server not clip over a pvc.

I'm sorry, ATM works on 2.4.23-pre8. I have disabled ipv6 in kernel 
config. ipv6 was connected with zebra config, zebra was connected with
routing. Anyway, it's works, sorry for false alarm.

-- 
*[ £ukasz Tr±biñski ]*
SysAdmin @wsisiz.edu.pl
