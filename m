Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265075AbTIJPhO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Sep 2003 11:37:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265083AbTIJPhO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Sep 2003 11:37:14 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:60814 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S265075AbTIJPhK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Sep 2003 11:37:10 -0400
Subject: Re: PROBLEM:SCSI repeatable 2.4.22 bug
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: flavio <flavio.l@tiscali.it>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <3F5F1B9E.607@tiscali.it>
References: <3F5F1B9E.607@tiscali.it>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063208157.32730.60.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-5) 
Date: Wed, 10 Sep 2003 16:35:58 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mer, 2003-09-10 at 13:39, flavio wrote:
> Hi,
> 
> the hd and dvd light are constantly on from boot onwards (using vanilla
> 2.4.22 and the /var/log/messages is a sequence of messages as in
> attachment).
> 2.4.20 vanilla has no problems whatsoever...

Your drive is returning more data than it was asked for or expected.
What model drives do you have and does turning off DMA for non disk fix
it ?

