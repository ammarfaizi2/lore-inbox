Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTDXFO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 01:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264411AbTDXFO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 01:14:26 -0400
Received: from dp.samba.org ([66.70.73.150]:17311 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id S264387AbTDXFO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 01:14:26 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: Pavel Machek <pavel@ucw.cz>
Cc: kernel list <linux-kernel@vger.kernel.org>, info@convergence.de
Subject: Re: Bad url in ioctl numbers [DVD decoder driver] 
In-reply-to: Your message of "Wed, 23 Apr 2003 15:52:50 +0200."
             <20030423135250.GA332@elf.ucw.cz> 
Date: Thu, 24 Apr 2003 15:21:49 +1000
Message-Id: <20030424052634.BE1272C11D@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In message <20030423135250.GA332@elf.ucw.cz> you write:
> Hi!
> 
> This warns about bad url. I do not know what better to do with this.

If you don't have a better one, just leave it.  I don't think this
patch helps.

>  0xA2    00-0F   DVD decoder driver      in development:
> -                                        <http://linuxtv.org/dvd/api/>
> +					URL no longer works: http://linuxtv.org/dvd/api/

Cheers,
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
