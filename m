Return-Path: <linux-kernel-owner+w=401wt.eu-S932816AbWLNPk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932816AbWLNPk2 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 10:40:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932815AbWLNPk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 10:40:28 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:36284 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932812AbWLNPk0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 10:40:26 -0500
Date: Thu, 14 Dec 2006 15:48:44 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: "Alessandro Suardi" <alessandro.suardi@gmail.com>
Cc: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.20-rc1
Message-ID: <20061214154844.437b95dc@localhost.localdomain>
In-Reply-To: <5a4c581d0612140559l6ecb2343o26dd31ace0cd7dd5@mail.gmail.com>
References: <Pine.LNX.4.64.0612131744290.5718@woody.osdl.org>
	<5a4c581d0612140559l6ecb2343o26dd31ace0cd7dd5@mail.gmail.com>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 14:59:23 +0100
"Alessandro Suardi" <alessandro.suardi@gmail.com> wrote:

> On 12/14/06, Linus Torvalds <torvalds@osdl.org> wrote:
> >
> > Ok, the two-week merge period is over, and -rc1 is out there.
> 
> Still need this libata-sff.c patch:
> 
> http://marc.theaimsgroup.com/?l=linux-kernel&m=116343564202844&q=raw
> 
>  to have my root device detected, ata_piix probe would otherwise
>  fail as described in this thread:
> 
> http://www.ussg.iu.edu/hypermail/linux/kernel/0612.0/0690.html
> 

Yep - sorry about not dealing with this yet but I've not had opportunity
to do much but email. I'm grabbing 20-rc1 atm to check there are no other
outstanding bits.

Alan
