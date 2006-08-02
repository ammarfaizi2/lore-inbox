Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751252AbWHBQ6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbWHBQ6H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 12:58:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWHBQ6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 12:58:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:58584 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751252AbWHBQ6F (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 12:58:05 -0400
Date: Wed, 2 Aug 2006 09:57:50 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Dominik Karall <dominik.karall@gmx.net>, linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>, Greg KH <greg@kroah.com>
Subject: Re: 2.6.18-rc1-mm2 and 2.6.18-rc3 (bttv: NULL pointer derefernce)
In-Reply-To: <20060802094904.2057eaf4.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0608020957220.4168@g5.osdl.org>
References: <20060713224800.6cbdbf5d.akpm@osdl.org> <200607141830.01858.dominik.karall@gmx.net>
 <200608021800.23905.dominik.karall@gmx.net> <20060802094904.2057eaf4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 2 Aug 2006, Andrew Morton wrote:
> 
> I believe this is fixed in Mauro's not-yet-pulled DVB tree?

Well, the DVB tree isn't _getting_ pulled, since it exploded in size after 
-rc1, and as such is not pullable any more.

		Linus
