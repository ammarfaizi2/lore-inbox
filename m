Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271784AbTGRR27 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 13:28:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270271AbTGRR15
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 13:27:57 -0400
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:23059 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S270244AbTGRR1t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 13:27:49 -0400
Date: Fri, 18 Jul 2003 18:42:41 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Eric Blade <eblade@blackmagik.dynup.net>
cc: petero2@telia.com, <linux-kernel@vger.kernel.org>
Subject: Re: radeonfb patch for 2.4.22...
In-Reply-To: <3F172693.2060701@blackmagik.dynup.net>
Message-ID: <Pine.LNX.4.44.0307181842070.10769-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> So, basically, it's normal, as I thought. 
> 
> Perhaps a quick clear screen as it's initialized would be good...

I think so. For 2.5.X it woudl be just a matter of calling 
xxxfb_fillrect to clear the screen.


