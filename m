Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750969AbWEEFpE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750969AbWEEFpE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 01:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750978AbWEEFpE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 01:45:04 -0400
Received: from mcr-smtp-001.bulldogdsl.com ([212.158.248.7]:39438 "EHLO
	mcr-smtp-001.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S1750969AbWEEFpC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 01:45:02 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Chris Wright <chrisw@sous-sol.org>
Subject: Re: Linux 2.6.16.14
Date: Fri, 5 May 2006 03:47:51 +0100
User-Agent: KMail/1.9.1
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-kernel@vger.kernel.org,
       stable@kernel.org, torvalds@osdl.org
References: <20060505003526.GW24291@moss.sous-sol.org> <200605051152.39693.ncunningham@cyclades.com> <20060505023353.GA24291@moss.sous-sol.org>
In-Reply-To: <20060505023353.GA24291@moss.sous-sol.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605050347.51703.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 05 May 2006 03:33, Chris Wright wrote:
> * Nigel Cunningham (ncunningham@cyclades.com) wrote:
> > Is this supposed to be some sort of subtle pressure on Linus to open 2.7?
> > :>
>
> He does every couple months and leaves it open for a few weeks.
> Then, just to keep us guessing, he releases it with a 2.6 name ;-)
>
> Actually, I think the system is working quite well.  We've got a quick
> route for getting bug fixes and security fixes to users, and a shorter
> devel cycle helping distro folks get more regular drops from upstream.

I think it's working extremely well. When it comes to security fixes, I want 
them as soon as possible. There's no sense batching them.

The only thing to be careful of is that -stable fixes (or complete reworks) 
get merged with mainline, so the trees don't go out of sync. So far this 
seems to have been OK.

-- 
Cheers,
Alistair.

Third year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
