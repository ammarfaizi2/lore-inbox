Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261659AbVAXV0C@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261659AbVAXV0C (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jan 2005 16:26:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261595AbVAXVYf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jan 2005 16:24:35 -0500
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:7900 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S261640AbVAXVVx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jan 2005 16:21:53 -0500
Date: Mon, 24 Jan 2005 22:18:49 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: 2df@tuxfamily.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: Bug report : drivers/net/hamradio/Kconfig
Message-ID: <20050124211849.GA20160@electric-eye.fr.zoreil.com>
References: <1294.213.228.34.135.1106596995.squirrel@webmail.tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1294.213.228.34.135.1106596995.squirrel@webmail.tuxfamily.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2df@tuxfamily.org <2df@tuxfamily.org> :
[...]
> I've also made a patch, my first too :))) :
> http://bugzilla.kernel.org/attachment.cgi?id=4450&action=view
> 
> I don't know if the patch is correct, but i think

The second hunk is not strictly needed. It could be removed.

> Should I do some other thing ?

Please follow the instructions at:
http://www.kernel.org/pub/linux/kernel/people/rusty/trivial/

--
Ueimor
