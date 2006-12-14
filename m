Return-Path: <linux-kernel-owner+w=401wt.eu-S932698AbWLNMhk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932698AbWLNMhk (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 07:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932700AbWLNMhk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 07:37:40 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:39419 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S932698AbWLNMhj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 07:37:39 -0500
Date: Thu, 14 Dec 2006 12:45:58 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: =?UTF-8?B?SGFucy1Kw7xyZ2Vu?= Koch <hjk@linutronix.de>
Cc: tglx@linutronix.de, Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: Userspace I/O driver core
Message-ID: <20061214124558.3bda956b@localhost.localdomain>
In-Reply-To: <200612141237.16535.hjk@linutronix.de>
References: <20061214010608.GA13229@kroah.com>
	<1166095336.29505.97.camel@localhost.localdomain>
	<20061214113933.07140f0a@localhost.localdomain>
	<200612141237.16535.hjk@linutronix.de>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Dec 2006 12:37:16 +0100
Hans-Jürgen Koch <hjk@linutronix.de> wrote:

> There are three breaks in that while loop, the first makes it return as 
> soon as an interrupt occurs.

Doh ignore that I misread it. Perils of reading email before midday
