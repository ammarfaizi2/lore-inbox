Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbULAJbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbULAJbv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Dec 2004 04:31:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbULAJbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Dec 2004 04:31:51 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:19934 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S261320AbULAJbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Dec 2004 04:31:48 -0500
Subject: Re: Suspend 2 merge
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Pavel Machek <pavel@suse.cz>
Cc: Stefan Seyfried <seife@suse.de>, Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       hugang@soulinfo.com, Andrew Morton <akpm@zip.com.au>
In-Reply-To: <20041130222027.GE1361@elf.ucw.cz>
References: <20041124132839.GA13145@infradead.org>
	 <1101329104.3425.40.camel@desktop.cunninghams>
	 <20041125192016.GA1302@elf.ucw.cz>
	 <1101422088.27250.93.camel@desktop.cunninghams>
	 <20041125232200.GG2711@elf.ucw.cz>
	 <1101426416.27250.147.camel@desktop.cunninghams> <41AAED32.2010703@suse.de>
	 <1101766833.4343.425.camel@desktop.cunninghams> <41AC6480.6020002@suse.de>
	 <1101849416.5715.13.camel@desktop.cunninghams>
	 <20041130222027.GE1361@elf.ucw.cz>
Content-Type: text/plain
Message-Id: <1101893275.5073.0.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 01 Dec 2004 20:27:55 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-12-01 at 09:20, Pavel Machek wrote:
> Hi!
> 
> > > >>Putting only the absolutely necessary things into the kernel (the same
> > > >>is true for the interactive resume thing - if someone wants interactive
> > > >>startup at a failing resume, he has to use an initrd, i don't see a
> > > >>problem with that) will probably increase the acceptance a bit :-)
> > > > 
> > > > That's fine if your initrd is properly configured and you're willing to
> > > 
> > > This is something distributions have to take care of.
> > 
> > No; it's something the users will have to take care of. Distro makers
> > might make the process more automated, but in the end it's the user's
> > problem if it doesn't work.
> 
> Actually, no, its not like that. 
> 
> User will click icon in KDE, and if it does not suspend & resume
> properly, distribution has problem to fix. And yes, it works well in
> SUSE9.2.

I didn't know you had support for initramfs and initrd configurations
already. You are making progress.

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

You see, at just the right time, when we were still powerless, Christ
died for the ungodly.		-- Romans 5:6

