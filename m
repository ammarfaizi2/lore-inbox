Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030185AbVKPRnR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030185AbVKPRnR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 12:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030283AbVKPRnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 12:43:17 -0500
Received: from atlrel9.hp.com ([156.153.255.214]:36031 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S1030185AbVKPRnR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 12:43:17 -0500
Subject: Re: [PATCH] backup timer for UARTs that lose interrupts (take 2)
From: Alex Williamson <alex.williamson@hp.com>
To: george@mvista.com
Cc: rmk+serial@arm.linux.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <437B6C9C.3060307@mvista.com>
References: <1132158489.5457.10.camel@tdi>  <437B6C9C.3060307@mvista.com>
Content-Type: text/plain
Organization: LOSL
Date: Wed, 16 Nov 2005 10:44:47 -0700
Message-Id: <1132163087.5457.21.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-11-16 at 09:30 -0800, George Anzinger wrote:
> Could you _please_ not put inline patches after the signature mark ("-- ").  In my mailer (mozilla) 
> this causes the patch to be greyed out and, more importantly, NOT included in a reply.  This, in 
> turn, makes it hard to comment on details in the patch.

  Sorry, I'll avoid that in the future.  With Evolution, If you
highlight part of the message before you reply it will include the
highlighted portions in the reply and disregard the sig mark.  Do you
have specific comments about this patch?  I think this patch is short
enough to cut-n-paste, so I'll refrain from re-posting unless you have
objections.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

