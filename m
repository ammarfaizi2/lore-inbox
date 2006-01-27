Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751453AbWA0OgU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751453AbWA0OgU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 09:36:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751455AbWA0OgU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 09:36:20 -0500
Received: from bayc1-pasmtp04.bayc1.hotmail.com ([65.54.191.164]:54825 "EHLO
	BAYC1-PASMTP04.bayc1.hotmail.com") by vger.kernel.org with ESMTP
	id S1751453AbWA0OgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 09:36:19 -0500
Message-ID: <BAYC1-PASMTP044EEF6AE96F3A240FF750AE140@CEZ.ICE>
X-Originating-IP: [69.156.6.171]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Fri, 27 Jan 2006 09:31:03 -0500
From: sean <seanlkml@sympatico.ca>
To: Karel Kulhavy <clock@twibright.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel manual pages
Message-Id: <20060127093103.4f196745.seanlkml@sympatico.ca>
In-Reply-To: <20060127092623.GA7882@kestrel>
References: <20060127092623.GA7882@kestrel>
X-Mailer: Sylpheed version 2.0.4 (GTK+ 2.8.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Jan 2006 14:36:18.0190 (UTC) FILETIME=[08B1DAE0:01C6234F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 Jan 2006 10:26:23 +0100
Karel Kulhavy <clock@twibright.com> wrote:

> Who is responsible for writing the linux kernel manual pages?  I went to
> vger.kernel.org and there is "There is much information about Linux on
> the web." which points to 7 different 3rd party websites.  I searched
> for "manual" and "manpage" in all 7 and didn't find any mention of
> manual pages.
> 

Take a look in the MAINTAINERS file in the kernel source:

MAN-PAGES: MANUAL PAGES FOR LINUX -- Sections 2, 3, 4, 5, and 7
P: Michael Kerrisk
M: mtk-manpages@gmx.net
W: ftp://ftp.kernel.org/pub/linux/docs/manpages
S: Maintained


Sean
