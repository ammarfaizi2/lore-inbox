Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261831AbULVKfD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261831AbULVKfD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Dec 2004 05:35:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261960AbULVKfD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Dec 2004 05:35:03 -0500
Received: from host245-95.pool217223.interbusiness.it ([217.223.95.245]:5509
	"EHLO localhost.localdomain") by vger.kernel.org with ESMTP
	id S261831AbULVKe7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Dec 2004 05:34:59 -0500
Subject: Re: ATARAID and KERNEL-2.6.9
From: Sasa Ostrouska <sasa.ostrouska@volja.net>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <41C879E8.4040001@pobox.com>
References: <1103642333.5591.5.camel@localhost> <41C879E8.4040001@pobox.com>
Content-Type: text/plain
Date: Wed, 22 Dec 2004 11:33:02 +0100
Message-Id: <1103711582.5608.6.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2004-12-21 at 14:30 -0500, Jeff Garzik wrote:
> Sasa Ostrouska wrote:
> > Dear Sirs,
> > 
> >         I have a little problem or maybe big one. I try to 
> > put to work the kernel-2.6.9 on my machine. I have a slackware
> > current install and the following hardware.
> 
> use dmraid for 2.6.x.
> 
> 	Jeff
> 
> 
> 
Dear Jeff, 

	Many thanks for your reply. I would like to ask you if 
you have some experience with this ? This means if you can point me to a
good how to or some documentation on the net, or maybe 
describe how to do the steps. This just because I tried to instal the
lilo but it gave me an error when I did /sbin/lilo and the root option
was set to /dev/ataraid/d0. I tried once to 
boot the machine with the options like noinitrd root=/dev/hde and it
booted up but then complained that the partitiona are mounted rw and to
give the root password for correcting the errors. After that I rebooted
to give the ro option and it never had booted again. 

Many many thanks for your help.

Best Regards
Sasa Ostrouska


