Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129816AbRCATYM>; Thu, 1 Mar 2001 14:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129823AbRCATYB>; Thu, 1 Mar 2001 14:24:01 -0500
Received: from [63.68.113.130] ([63.68.113.130]:21419 "EHLO fire.osdlab.org")
	by vger.kernel.org with ESMTP id <S129816AbRCATXn>;
	Thu, 1 Mar 2001 14:23:43 -0500
Date: Thu, 1 Mar 2001 11:22:13 -0800
To: Hans Reiser <reiser@namesys.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: What is 2.4 Linux networking performance like compared to BSD?
Message-ID: <20010301112213.B30284@osdlab.org>
In-Reply-To: <Pine.A41.4.33.0102282123180.68876-100000@aix09.unm.edu> <3A9E72D3.36B28B8F@namesys.com> <20010301090416.E27440@osdlab.org> <3A9E96A6.41D725A3@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
In-Reply-To: <3A9E96A6.41D725A3@namesys.com>; from reiser@namesys.com on Thu, Mar 01, 2001 at 09:36:22PM +0300
From: Nathan Dabney <smurf@osdlab.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 01, 2001 at 09:36:22PM +0300, Hans Reiser wrote:
> Nathan Dabney wrote:
> > 
> > On Thu, Mar 01, 2001 at 07:03:31PM +0300, Hans Reiser wrote:
> > 
> > The above link contains some decent squid performance hints for 2.2+Squid.
> > 
> > -Nathan Dabney
> It does not say anything about BSD vs. Linux 2.4 networking code.
> 
> If I can't get information about BSD v. Linux 2.4 networking code, then reiserfs
> has to get ported to BSD which will be both nice and a pain to do.
> 
> Hans

Correct, it only has information which would help tune the setup you first described (the 2.2 setup for your client).

The individuals doing the technical side of that company have a high level of knowledge regarding Linux kernel issues which affect Squid performance and can /possibly/ discuss 2.4 vs. BSD issues with you if you ask.

However, for your client I believe the "technical information" would not be as useful as demonstrated performance.  I can't imagine that testing squid would require that much effort when compared to porting resierfs.

It's up to you of course.

-Nathan 

