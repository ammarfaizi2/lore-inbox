Return-Path: <linux-kernel-owner+w=401wt.eu-S1751448AbXAFSfW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbXAFSfW (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 13:35:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbXAFSfW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 13:35:22 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:40489 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751448AbXAFSfV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 13:35:21 -0500
Date: Sat, 6 Jan 2007 10:33:31 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "J.H." <warthog9@kernel.org>
Cc: Willy Tarreau <w@1wt.eu>, Andrew Morton <akpm@osdl.org>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-Id: <20070106103331.48150aed.randy.dunlap@oracle.com>
In-Reply-To: <1166511171.26330.120.camel@localhost.localdomain>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
	<20061216095702.3e6f1d1f.akpm@osdl.org>
	<458434B0.4090506@oracle.com>
	<1166297434.26330.34.camel@localhost.localdomain>
	<20061219063413.GI24090@1wt.eu>
	<1166511171.26330.120.camel@localhost.localdomain>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Whitelist: TRUE
X-Whitelist: TRUE
X-Brightmail-Tracker: AAAAAQAAAAI=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Dec 2006 22:52:51 -0800 J.H. wrote:

> On Tue, 2006-12-19 at 07:34 +0100, Willy Tarreau wrote:
> > On Sat, Dec 16, 2006 at 11:30:34AM -0800, J.H. wrote:
> > (...)
> > 
> > > So we know the problem is there, and we are working on it - we are
> > > getting e-mails about it if not daily than every other day or so.  If
> > > there are suggestions we are willing to hear them - but the general
> > > feeling with the admins is that we are probably hitting the biggest
> > > problems already.
> > 
> > BTW, yesterday my 2.4 patches were not published, but I noticed that
> > they were not even signed not bziped on hera. At first I simply thought
> > it was related, but right now I have a doubt. Maybe the automatic script
> > has been temporarily been disabled on hera too ?
> 
> The script that deals with the uploads also deals with the packaging -
> so yes the problem is related.

and with the finger_banner and version info on www.kernel.org page?

They currently say:

The latest stable version of the Linux kernel is:           2.6.19.1
The latest prepatch for the stable Linux kernel tree is:    2.6.20-rc3
The latest snapshot for the stable Linux kernel tree is:    2.6.20-rc3-git4
The latest 2.4 version of the Linux kernel is:              2.4.34
The latest 2.2 version of the Linux kernel is:              2.2.26
The latest prepatch for the 2.2 Linux kernel tree is:       2.2.27-rc2
The latest -mm patch to the stable Linux kernels is:        2.6.20-rc2-mm1


but there are 2.6.20-rc3-git[567] and 2.6.20-rc3-mm1 out there,
so when is the finger version info updated?

Thanks,
---
~Randy
