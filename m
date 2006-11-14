Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966448AbWKNXTW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966448AbWKNXTW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:19:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966453AbWKNXTW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:19:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:5564 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S966448AbWKNXTV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:19:21 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,422,1157353200"; 
   d="scan'208"; a="161556520:sNHT24361736"
Message-ID: <455A4EF8.5030004@foo-projects.org>
Date: Tue, 14 Nov 2006 15:19:20 -0800
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.7 (X11/20060918)
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
Subject: Re: nightly 2.6 LXR run?
References: <1163530480.16381.23.camel@jcm.boston.redhat.com> <slrnelkj1s.7lr.olecom@flower.upol.cz>
In-Reply-To: <slrnelkj1s.7lr.olecom@flower.upol.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Nov 2006 23:19:20.0881 (UTC) FILETIME=[5071BA10:01C70843]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Verych wrote:
> Hallo.
> On 2006-11-14, Jon Masters wrote:
>> Hi folks,
>>
>> So I'm curious (before I do it) whether anyone is currently running an
>> automated nightly LXR against Linus' git kernel tree?
> 
> I don't think so. Also, i don't think, it's useful for development.
> There are TAGS/tags make targets for it, and they're more productive, i think.
> 
> But what really will be helpful (well, for me), is another git-web public 
> service on Linus' git tree. kernel.org is very heavy loaded with many
> things, so normally i get "The load average on the server is too high",
> when trying to trace some code history and reading logs. There were
> some lkml posts, even from Linus, stating, that kernel.org is very
> loaded and slow.

try to use `git2.kernel.org` instead of `git.kernel.org`. The second server somehow only 
has an average load of ~4 instead of ~250.

Cheers,

Auke
