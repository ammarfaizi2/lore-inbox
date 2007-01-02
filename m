Return-Path: <linux-kernel-owner+w=401wt.eu-S964982AbXABVCl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964982AbXABVCl (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:02:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964977AbXABVCk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:02:40 -0500
Received: from 74-93-104-97-Washington.hfc.comcastbusiness.net ([74.93.104.97]:44750
	"EHLO sunset.davemloft.net" rhost-flags-OK-FAIL-OK-OK)
	by vger.kernel.org with ESMTP id S964972AbXABVCj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:02:39 -0500
Date: Tue, 02 Jan 2007 13:02:38 -0800 (PST)
Message-Id: <20070102.130238.07641846.davem@davemloft.net>
To: bunk@stusta.de
Cc: samuel@sortiz.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] net/irda/: proper prototypes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20070102124557.GQ20714@stusta.de>
References: <20061218034626.GY10316@stusta.de>
	<20070102.003953.21925510.davem@davemloft.net>
	<20070102124557.GQ20714@stusta.de>
X-Mailer: Mew version 5.1.52 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Adrian Bunk <bunk@stusta.de>
Date: Tue, 2 Jan 2007 13:45:57 +0100

> On Tue, Jan 02, 2007 at 12:39:53AM -0800, David Miller wrote:
> > I don't like it, even if it's "correct", because it is inconsistent
> > with what we do in the entire rest of the networking code.
> 
> Good point.
> 
> Is it OK to slowly starting converting them or do you want them to stay?

If I saw some value in it I'd say to convert, but I don't so
I'd say let's keep them the way they are.
