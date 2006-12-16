Return-Path: <linux-kernel-owner+w=401wt.eu-S1161288AbWLPR6V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161288AbWLPR6V (ORCPT <rfc822;w@1wt.eu>);
	Sat, 16 Dec 2006 12:58:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161289AbWLPR6V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Dec 2006 12:58:21 -0500
Received: from smtp.osdl.org ([65.172.181.25]:59419 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161288AbWLPR6U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Dec 2006 12:58:20 -0500
Date: Sat, 16 Dec 2006 09:57:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       hpa@zytor.com, webmaster@kernel.org
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
Message-Id: <20061216095702.3e6f1d1f.akpm@osdl.org>
In-Reply-To: <20061216094421.416a271e.randy.dunlap@oracle.com>
References: <20061214223718.GA3816@elf.ucw.cz>
	<20061216094421.416a271e.randy.dunlap@oracle.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Dec 2006 09:44:21 -0800
Randy Dunlap <randy.dunlap@oracle.com> wrote:

> On Thu, 14 Dec 2006 23:37:18 +0100 Pavel Machek wrote:
> 
> > Hi!
> > 
> > pavel@amd:/data/pavel$ finger @www.kernel.org
> > [zeus-pub.kernel.org]
> > ...
> > The latest -mm patch to the stable Linux kernels is: 2.6.19-rc6-mm2
> > pavel@amd:/data/pavel$ head /data/l/linux-mm/Makefile
> > VERSION = 2
> > PATCHLEVEL = 6
> > SUBLEVEL = 19
> > EXTRAVERSION = -mm1
> > ...
> > pavel@amd:/data/pavel$
> > 
> > AFAICT 2.6.19-mm1 is newer than 2.6.19-rc6-mm2, but kernel.org does
> > not understand that.
> 
> Still true (not listed) for 2.6.20-rc1-mm1  :(
> 
> Could someone explain what the problem is and what it would
> take to correct it?

2.6.20-rc1-mm1 still hasn't propagated out to the servers (it's been 36
hours).  Presumably the front page non-update is a consequence of that.

