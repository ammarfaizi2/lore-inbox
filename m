Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261960AbTEBIly (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 04:41:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTEBIlw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 04:41:52 -0400
Received: from [196.41.29.142] ([196.41.29.142]:5374 "EHLO
	workshop.saharact.lan") by vger.kernel.org with ESMTP
	id S261960AbTEBIlA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 04:41:00 -0400
Subject: Re: OSS support for ICH5 sound
From: Martin Schlemmer <azarah@gentoo.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: KML <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <3EB1F886.3000106@pobox.com>
References: <1051823687.11068.11.camel@nosferatu.lan>
	 <3EB1F886.3000106@pobox.com>
Content-Type: text/plain
Organization: 
Message-Id: <1051865298.5677.44.camel@workshop.saharact.lan>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3- 
Date: 02 May 2003 10:48:18 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-05-02 at 06:48, Jeff Garzik wrote:

> Unfortunately this doesn't work on all ICH5s out there.  At the very 
> minimum, for now, it would be nice to match up ich5 and codec pairs, as 
> codec differentiation seems to be what stops this patch from working on 
> all ICH5.
> 

Hmm, right.

Anybody working on getting support for the 875 Chipset into 2.5?
Can I send a 'lspci -vv' to help ?  I have a Asus P4C800 here (Intel
875p), so I can do some testing if need be.


Regards,

-- 
Martin Schlemmer


