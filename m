Return-Path: <linux-kernel-owner+w=401wt.eu-S932147AbXALPvX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932147AbXALPvX (ORCPT <rfc822;w@1wt.eu>);
	Fri, 12 Jan 2007 10:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932158AbXALPvW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Jan 2007 10:51:22 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:41721 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932147AbXALPvU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Jan 2007 10:51:20 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Subject: Re: 2.6.20-rc4-mm1 md problem
Date: Fri, 12 Jan 2007 16:52:46 +0100
User-Agent: KMail/1.9.1
Cc: "Andrew Morton" <akpm@osdl.org>, "Ingo Molnar" <mingo@elte.hu>,
       "Neil Brown" <neilb@cse.unsw.edu.au>,
       LKML <linux-kernel@vger.kernel.org>
References: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
In-Reply-To: <6bffcb0e0701120533o609489den9ca02f42e4d4839@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200701121652.46896.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 12 January 2007 14:33, Michal Piotrowski wrote:
> My system hangs on this
> http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/bug2.jpg
> http://www.stardust.webpages.pl/files/tbf/euridica/2.6.20-rc4-mm1/mm-config
> 
> Debug plan:
> - revert md-* patches
> - binary search
> 
> Does someone have a better idea?

Revert git-block.patch and related stuff?

Greetings,
Rafael


-- 
If you don't have the time to read,
you don't have the time or the tools to write.
		- Stephen King
