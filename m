Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751232AbWFLJkD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751232AbWFLJkD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Jun 2006 05:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751371AbWFLJkD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Jun 2006 05:40:03 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:19107 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751232AbWFLJkC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Jun 2006 05:40:02 -0400
Subject: Re: [Patch] Cyclades Cleanup
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: linux-kernel@vger.kernel.org
In-Reply-To: <1150060480.9319.2.camel@alice>
References: <1150060480.9319.2.camel@alice>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 12 Jun 2006 10:56:08 +0100
Message-Id: <1150106168.22124.157.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 (2.6.1-1.fc5.2) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Sul, 2006-06-11 am 23:14 +0200, ysgrifennodd Eric Sesterhenn:
> hi,
> 
> coverity choked at two !tty checks, in places where tty can
> never be NULL. Since it removes some code we should remove
> these checks. (Coverity ids #763,#762)
> 
> Signed-off-by Eric Sesterhenn <snakebyte@gmx.de>

Acked-by: Alan Cox <alan@redhat.com>

