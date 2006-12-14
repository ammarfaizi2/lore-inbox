Return-Path: <linux-kernel-owner+w=401wt.eu-S932697AbWLNMks@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932697AbWLNMks (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932703AbWLNMks
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:40:48 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:33998 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932697AbWLNMkr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:40:47 -0500
Date: Thu, 14 Dec 2006 13:39:48 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Avi Kivity <avi@argo.co.il>
cc: =?ISO-8859-1?Q?Hans-J=FCrgen_Koch?= <hjk@linutronix.de>,
       linux-kernel@vger.kernel.org
Subject: Re: Userspace I/O driver core
In-Reply-To: <45812C17.4090309@argo.co.il>
Message-ID: <Pine.LNX.4.61.0612141338490.6223@yvahk01.tjqt.qr>
References: <20061214010608.GA13229@kroah.com> <45811D0F.2070705@argo.co.il>
 <200612141125.14777.hjk@linutronix.de> <45812C17.4090309@argo.co.il>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It has to be written once, but compiled for every kernel
> version and $arch out there (for out of tree drivers), or it
> has to wait for the next kernel release and distro sync (for
> in-tree drivers).

Still better than written for every _and_ compiled for every.
But wait, make it simpler: just give the source to the user and
don't bother with precompiling. It's such a PITA anyhow.


	-`J'
-- 
