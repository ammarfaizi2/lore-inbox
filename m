Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWEJOf5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWEJOf5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 10:35:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751456AbWEJOf5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 10:35:57 -0400
Received: from [63.81.120.158] ([63.81.120.158]:59509 "EHLO
	gateway-1237.mvista.com") by vger.kernel.org with ESMTP
	id S1751451AbWEJOf4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 10:35:56 -0400
Subject: Re: [BUG] mtd redboot (also gcc 4.1 warning fix)
From: Daniel Walker <dwalker@mvista.com>
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060510053701.GO3570@stusta.de>
References: <200605100256.k4A2u4FO031737@dwalker1.mvista.com>
	 <20060510053701.GO3570@stusta.de>
Content-Type: text/plain
Date: Wed, 10 May 2006 07:35:48 -0700
Message-Id: <1147271748.21536.73.camel@c-67-180-134-207.hsd1.ca.comcast.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-05-10 at 07:37 +0200, Adrian Bunk wrote:
> On Tue, May 09, 2006 at 07:56:04PM -0700, Daniel Walker wrote:
> 
> > unsigned long may not always be 32 bits, right ? This patch fixes the 
> > warning, but not the bug .
> >...
> 
> IOW, all your patch does is to hide a bug?
> 
> Not exactly an improvement...

This is a _bug report_ , not a fix .

Daniel

