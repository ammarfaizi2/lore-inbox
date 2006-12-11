Return-Path: <linux-kernel-owner+w=401wt.eu-S937691AbWLKWj1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937691AbWLKWj1 (ORCPT <rfc822;w@1wt.eu>);
	Mon, 11 Dec 2006 17:39:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937694AbWLKWj1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Dec 2006 17:39:27 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:49864 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937691AbWLKWj0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Dec 2006 17:39:26 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.19-mm1
Date: Mon, 11 Dec 2006 23:41:41 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, Neil Brown <neilb@suse.de>
References: <20061211005807.f220b81c.akpm@osdl.org>
In-Reply-To: <20061211005807.f220b81c.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612112341.42140.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 11 December 2006 09:58, Andrew Morton wrote:
> 
> Temporarily at
> 
> 	http://userweb.kernel.org/~akpm/2.6.19-mm1/
> 
> Will appear later at
> 
> 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19/2.6.19-mm1/

It caused all of the md RAID1s on my test box to drop one of their partitions,
apparently at random.

Greetings,
Rafael
