Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263739AbTHWORh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 10:17:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263554AbTHWORg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 10:17:36 -0400
Received: from AMarseille-201-1-3-186.w193-253.abo.wanadoo.fr ([193.253.250.186]:25383
	"EHLO gaston") by vger.kernel.org with ESMTP id S263429AbTHWOPB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 10:15:01 -0400
Subject: Re: [PATCH] 2.6.0-test4 PowerMac floppy driver fixes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@csd.uu.se>
Cc: linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       linuxppc-devel@lists.linuxppc.org, Paul Mackerras <paulus@samba.org>
In-Reply-To: <200308231223.h7NCNQ5p017957@harpo.it.uu.se>
References: <200308231223.h7NCNQ5p017957@harpo.it.uu.se>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061648087.805.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Sat, 23 Aug 2003 16:14:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2003-08-23 at 14:23, Mikael Pettersson wrote:
> The PowerMac floppy driver (swim3) is seriously broken in 2.6:
> it doesn't compile, it isn't initialized, and it lacks Paul Mackerras'
> 2.4 kernel swim3 fixes from March 29 this year.
> 
> Below is an update to 2.6.0-test4's swim3.c which fixes these issues.
> I've been using this since early 2.5.7x with no problems.

Thanks, that will be in my next round of patches.

Ben.

