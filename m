Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264058AbUEHSrS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264058AbUEHSrS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 May 2004 14:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264095AbUEHSrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 May 2004 14:47:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:57036 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264058AbUEHSrR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 May 2004 14:47:17 -0400
Date: Sat, 8 May 2004 11:46:48 -0700
From: Andrew Morton <akpm@osdl.org>
To: Bruce Guenter <bruceg@em.ca>
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org
Subject: Re: 2.6.6-rc3-mm2
Message-Id: <20040508114648.4e61bf31.akpm@osdl.org>
In-Reply-To: <20040508165902.GF25615@em.ca>
References: <20040505013135.7689e38d.akpm@osdl.org>
	<20040506195223.017cd7f6.akpm@osdl.org>
	<1083903398.7481.43.camel@bach>
	<200405072213.23167.rjwysocki@sisk.pl>
	<20040507230915.447a92fa.akpm@osdl.org>
	<20040508165902.GF25615@em.ca>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bruce Guenter <bruceg@em.ca> wrote:
>
> On Fri, May 07, 2004 at 11:09:15PM -0700, Andrew Morton wrote:
> > Works for me too.  Can you share your kernel boot commandline with us?
> 
> Sure.  I use (in grub):
> 	kernel /vmlinuz-2.6.6-rc2-mm2 vga=1 ro root=/dev/md15 elevator=deadline console=ttyS0,115200n8

oh, and you're using x86_64 too.
