Return-Path: <linux-kernel-owner+w=401wt.eu-S932387AbXAGEaT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932387AbXAGEaT (ORCPT <rfc822;w@1wt.eu>);
	Sat, 6 Jan 2007 23:30:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932388AbXAGEaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Jan 2007 23:30:19 -0500
Received: from smtp.osdl.org ([65.172.181.24]:58673 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932387AbXAGEaR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Jan 2007 23:30:17 -0500
Date: Sat, 6 Jan 2007 20:29:26 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jeff Garzik <jeff@garzik.org>
cc: nigel@nigel.suspend2.net, "H. Peter Anvin" <hpa@zytor.com>,
       Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
       "J.H." <warthog9@kernel.org>, Randy Dunlap <randy.dunlap@oracle.com>,
       Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>,
       webmaster@kernel.org, Git Mailing List <git@vger.kernel.org>
Subject: Re: [KORG] Re: kernel.org lies about latest -mm kernel
In-Reply-To: <45A07587.3080503@garzik.org>
Message-ID: <Pine.LNX.4.64.0701062029170.3661@woody.osdl.org>
References: <20061214223718.GA3816@elf.ucw.cz>  <20061216094421.416a271e.randy.dunlap@oracle.com>
  <20061216095702.3e6f1d1f.akpm@osdl.org>  <458434B0.4090506@oracle.com> 
 <1166297434.26330.34.camel@localhost.localdomain>  <1166304080.13548.8.camel@nigel.suspend2.net>
  <459152B1.9040106@zytor.com> <1168140954.2153.1.camel@nigel.suspend2.net>
 <45A07587.3080503@garzik.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 6 Jan 2007, Jeff Garzik wrote:
> 
> Also, I wonder if "git push" will push only the non-linux-2.6.git objects, if
> both local and remote sides have the proper alternatives set up?

Yes.

		Linus
