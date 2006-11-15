Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030840AbWKOSjU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030840AbWKOSjU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 13:39:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030836AbWKOSjU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 13:39:20 -0500
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:34697 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S1030830AbWKOSjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 13:39:19 -0500
Date: Wed, 15 Nov 2006 19:38:52 +0100
From: Pavel Machek <pavel@ucw.cz>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Vivek Goyal <vgoyal@in.ibm.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Reloc Kernel List <fastboot@lists.osdl.org>, akpm@osdl.org, ak@suse.de,
       hpa@zytor.com, magnus.damm@gmail.com, lwang@redhat.com,
       dzickus@redhat.com
Subject: Re: [RFC] [PATCH 10/16] x86_64: 64bit PIC ACPI wakeup
Message-ID: <20061115183852.GA3724@elf.ucw.cz>
References: <20061113162135.GA17429@in.ibm.com> <20061113164314.GK17429@in.ibm.com> <20061114163002.GB4445@ucw.cz> <m1fyclk8ws.fsf@ebiederm.dsl.xmission.com> <20061114234334.GB3394@elf.ucw.cz> <m1lkmc4o5n.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1lkmc4o5n.fsf@ebiederm.dsl.xmission.com>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >> > Can we get it piece-by-piece?
> >
> > Please?
> 
> I honestly think it would make the change  less reviewable.

It included mass renames, "unused" code removal, and miscellaus
cleanups. At least seaparate cleanups from "real" changes.

							Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
