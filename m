Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265956AbUGILOh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265956AbUGILOh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 07:14:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265957AbUGILOg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 07:14:36 -0400
Received: from slimnet.xs4all.nl ([194.109.194.192]:44769 "EHLO slimnas.slim")
	by vger.kernel.org with ESMTP id S265956AbUGILOe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 07:14:34 -0400
Subject: Re: 2.6.7-mm7
From: Jurgen Kramer <gtm.kramer@inter.nl.net>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040709033950.6c7cf111.akpm@osdl.org>
References: <20040708235025.5f8436b7.akpm@osdl.org>
	 <1089369159.3198.4.camel@paragon.slim>
	 <20040709033950.6c7cf111.akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1089371792.3198.14.camel@paragon.slim>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Fri, 09 Jul 2004 13:16:32 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-07-09 at 12:39, Andrew Morton wrote:
> Jurgen Kramer <gtm.kramer@inter.nl.net> wrote:
> >
> > On Fri, 2004-07-09 at 08:50, Andrew Morton wrote:
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.7/2.6.7-mm7/
> > > 
> > My EHCI controller still won't come back to life. I have tried 
> > various boot options to no avail. I still gives:
> 
> Did you try "acpi=off"?
> 
> Try reverting bk-acpi.patch

Yes, I tried with acpi=off, the results are the same. I did the
reverting bk-acpi patch procedure as suggested by Len Brown on a
previous 2.6.7-mm version. The conclusion was that ACPI does not seem to
be the problem.

Jurgen


