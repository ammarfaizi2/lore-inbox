Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751180AbVLCETN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751180AbVLCETN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Dec 2005 23:19:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751179AbVLCETN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Dec 2005 23:19:13 -0500
Received: from smtp104.sbc.mail.re2.yahoo.com ([68.142.229.101]:27745 "HELO
	smtp104.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1751175AbVLCETN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Dec 2005 23:19:13 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: Two module-init-
Date: Fri, 2 Dec 2005 23:19:04 -0500
User-Agent: KMail/1.8.3
Cc: Scott James Remnant <scott@ubuntu.com>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, linux-input@atrey.karlin.mff.cuni.cz,
       vojtech@suse.cz
References: <1133359773.2779.13.camel@localhost.localdomain> <1133482376.4094.11.camel@localhost.localdomain>
In-Reply-To: <1133482376.4094.11.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512022319.05246.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 01 December 2005 19:12, Rusty Russell wrote:
> Meanwhile, as noone seems to use swbit in struct input_device_id,
> perhaps we can remove it for 2.6.15?
> 

Please take a look at drivers/input/keyboard/corgikbd.c

-- 
Dmitry
