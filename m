Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261872AbVBISJw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261872AbVBISJw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 13:09:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261875AbVBISJw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 13:09:52 -0500
Received: from av1-2-sn4.m-sp.skanova.net ([81.228.10.115]:37092 "EHLO
	av1-2-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S261872AbVBISJi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 13:09:38 -0500
To: Stephane Raimbault <stephane.raimbault@free.fr>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Touchpad problems with 2.6.11-rc2
References: <1107860158.5271.12.camel@picasso.lan> <m3oeev3rt7.fsf@telia.com>
	<1107938857.4456.3.camel@picasso.lan>
From: Peter Osterlund <petero2@telia.com>
Date: 09 Feb 2005 19:09:19 +0100
In-Reply-To: <1107938857.4456.3.camel@picasso.lan>
Message-ID: <m3fz05zju8.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Raimbault <stephane.raimbault@free.fr> writes:

> > Does the "Enable hardware tapping for ALPS touchpads" patch help?
> > 
> >         http://marc.theaimsgroup.com/?l=linux-kernel&m=110708138225873&w=2
> > 
> 
> Yes, works really better but the release event is sent only if I move
> the pointer. It's as if I still put my finger on the touchpad.

That's a different bug that has already been fixed in 2.6.11-rc3-bk6.

http://linus.bkbits.net:8080/linux-2.5/cset@42079714WEG-WI7P2exv58htWhdGDA?nav=index.html|ChangeSet@-4d

-- 
Peter Osterlund - petero2@telia.com
http://web.telia.com/~u89404340
