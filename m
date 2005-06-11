Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261695AbVFKMqZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbVFKMqZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Jun 2005 08:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261698AbVFKMqY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Jun 2005 08:46:24 -0400
Received: from hell.org.pl ([62.233.239.4]:26380 "HELO hell.org.pl")
	by vger.kernel.org with SMTP id S261695AbVFKMqJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Jun 2005 08:46:09 -0400
Date: Sat, 11 Jun 2005 14:19:23 +0200
From: Karol Kozimor <sziwan@hell.org.pl>
To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail@hboeck.de>
Cc: randy_dunlap <rdunlap@xenotime.net>, acpi-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, julien.lerouge@free.fr
Subject: Re: [ACPI] Re: Kernel oops with asus_acpi module
Message-ID: <20050611121923.GB20873@hell.org.pl>
Mail-Followup-To: Hanno =?iso-8859-2?Q?B=F6ck?= <mail@hboeck.de>,
	randy_dunlap <rdunlap@xenotime.net>,
	acpi-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org,
	julien.lerouge@free.fr
References: <200506052340.41074.mail@hboeck.de> <200506062347.10582.mail@hboeck.de> <20050606222151.GB65@hell.org.pl> <200506071946.20843.mail@hboeck.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200506071946.20843.mail@hboeck.de>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Hanno Böck:
> Am Dienstag, 7. Juni 2005 00:21 schrieb Karol Kozimor:
> > Thanks. This might also help:
> Doesn't help (randys fix also didn't).
> 
> > But I'd like to get the full oops with the matching asus_acpi.o file also
> > (might be off the list).
> 
> Can you tell me what a full oops is, how I generate it? Then I can do so (I'm 
> not a kernel-dev).

What I meant was the full log output (which, AFAIK, you did supply) and the
asus_acpi.o file from the kernel build that the specific oops report was
for, which only Randy received, I guess.

Anyway, I'll do a debug patch shortly.

Best regards,

-- 
Karol 'sziwan' Kozimor
sziwan@hell.org.pl
