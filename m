Return-Path: <linux-kernel-owner+w=401wt.eu-S1753990AbXACDCO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbXACDCO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 22:02:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754021AbXACDCO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 22:02:14 -0500
Received: from cnc.isely.net ([64.81.146.143]:44756 "EHLO cnc.isely.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753990AbXACDCN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 22:02:13 -0500
X-Greylist: delayed 306 seconds by postgrey-1.27 at vger.kernel.org; Tue, 02 Jan 2007 22:02:13 EST
Date: Tue, 2 Jan 2007 20:57:06 -0600 (CST)
From: Mike Isely <isely@isely.net>
Reply-To: Mike Isely <isely@pobox.com>
To: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
cc: video4linux-list@redhat.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Mike Isely at pobox <isely@pobox.com>
Subject: Re: [PATCH] video: pvrusb2-hdw kfree cleanup
In-Reply-To: <200701021326.46176.m.kozlowski@tuxland.pl>
Message-ID: <Pine.LNX.4.64.0701022056350.25513@cnc.isely.net>
References: <200701021244.21728.m.kozlowski@tuxland.pl>
 <200701021326.46176.m.kozlowski@tuxland.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 Jan 2007, Mariusz Kozlowski wrote:

> Hello, 
> 
> > 	This patch removes redundant argument check for kfree().
> > 
> >  drivers/media/video/pvrusb2/pvrusb2-hdw.c |   16 ++++++++--------
> >  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> Signed-off-by: Mariusz Kozlowski <m.kozlowski@tuxland.pl>
> 
> 

Signed-off-by: Mike Isely <isely@pobox.com>

  -Mike

-- 
                        |         Mike Isely          |     PGP fingerprint
     Spammers Die!!     |                             | 03 54 43 4D 75 E5 CC 92
                        |   isely @ pobox (dot) com   | 71 16 01 E2 B5 F5 C1 E8
                        |                             |
