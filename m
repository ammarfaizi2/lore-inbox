Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261524AbVF2Pnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261524AbVF2Pnu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Jun 2005 11:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVF2Pnt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Jun 2005 11:43:49 -0400
Received: from smtp.osdl.org ([65.172.181.4]:53961 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261517AbVF2Pnd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Jun 2005 11:43:33 -0400
Date: Wed, 29 Jun 2005 08:45:32 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.13-rc1 - bad tag in git tree?
In-Reply-To: <1120057260.9321.22.camel@kleikamp.austin.ibm.com>
Message-ID: <Pine.LNX.4.58.0506290845140.14331@ppc970.osdl.org>
References: <Pine.LNX.4.58.0506282310040.14331@ppc970.osdl.org>
 <1120057260.9321.22.camel@kleikamp.austin.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 29 Jun 2005, Dave Kleikamp wrote:
>
> $ cat refs/tags/v2.6.13-rc1
> 733ad933f62e82ebc92fed988c7f0795e64dea62
> 
> This object doesn't appear to be in the git tree.

Oh, it is, but I just forgot to push it to the public one ;)

		Linus
