Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267164AbUHOV4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267164AbUHOV4Z (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 17:56:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267165AbUHOV4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 17:56:25 -0400
Received: from the-village.bc.nu ([81.2.110.252]:15329 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S267164AbUHOV4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 17:56:24 -0400
Subject: Re: 2.6.8.1 Mis-detect CRDW as CDROM
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: John Wendel <jwendel10@comcast.net>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <411FD919.9030702@comcast.net>
References: <411FD919.9030702@comcast.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1092603225.18415.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 15 Aug 2004 21:53:46 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2004-08-15 at 22:43, John Wendel wrote:
> K3B detects my Lite-on LTR-52327S CDRW as a CDROM when run with 2.6.8.1. 
> Booting back into 2.6.7 corrects the problem. I've attached the (totally 
> uninteresting parts of) dmesg.  Any clues  appreciated.

The kernel really has no understanding of the difference here, and
the two dmesg files are identical so what makes you make that claim

