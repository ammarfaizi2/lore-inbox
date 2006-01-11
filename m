Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161035AbWAKHAt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbWAKHAt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 02:00:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161013AbWAKHAt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 02:00:49 -0500
Received: from [218.25.172.144] ([218.25.172.144]:58128 "HELO mail.fc-cn.com")
	by vger.kernel.org with SMTP id S1161004AbWAKHAs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 02:00:48 -0500
Date: Wed, 11 Jan 2006 15:00:43 +0800
From: Coywolf Qi Hunt <qiyong@fc-cn.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: why no -mm git tree?
Message-ID: <20060111070043.GA7858@localhost.localdomain>
References: <20060111055616.GA5976@localhost.localdomain> <20060110224451.44c9d3da.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060110224451.44c9d3da.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2006 at 10:44:51PM -0800, Andrew Morton wrote:
> Coywolf Qi Hunt <qiyong@fc-cn.com> wrote:
> >
> > Why don't use a -mm git tree?
> >
> 
> Because everthing would take me 100x longer?

Really? So does Linus?

> 
> I'm looking into generating a pullable git tree for each -mm.  Just as a
> convenience for people who can't type "ftp".

That doesn't help much if it's only for each -mm.
If you make git commits for each each patch merged in, then
we can always run the `current' -mm git tree.

Test the -mm patches, not leave them sleeping for most of the time.

> 
> That'll just be a dump of the whole -mm lineup into git.  I don't know how
> workable it'll be - we'll see.
> 

-- 
Coywolf Qi Hunt
