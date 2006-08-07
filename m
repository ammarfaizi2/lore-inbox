Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750778AbWHGQAY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750778AbWHGQAY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:00:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750783AbWHGQAY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:00:24 -0400
Received: from mtagate6.de.ibm.com ([195.212.29.155]:62817 "EHLO
	mtagate6.de.ibm.com") by vger.kernel.org with ESMTP
	id S1750778AbWHGQAX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:00:23 -0400
Subject: Re: [patch] s390: xpram system device class.
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1154965250.25998.44.camel@localhost.localdomain>
References: <20060807150639.GD10416@skybase>
	 <1154965250.25998.44.camel@localhost.localdomain>
Content-Type: text/plain
Organization: IBM Corporation
Date: Mon, 07 Aug 2006 18:00:07 +0200
Message-Id: <1154966407.23486.0.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2006-08-07 at 16:40 +0100, Alan Cox wrote:
> Ar Llu, 2006-08-07 am 17:06 +0200, ysgrifennodd Martin Schwidefsky:
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > 
> > [S390] xpram system device class.
> > 
> > Remove system device class for xpram. 
> > 
> 
> This seems to have various other changes in it - switches to atomic
> operations and the like which aren't explained..

Yes you are right. There is another patch mixed with this one. Thanks
for the hint.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


