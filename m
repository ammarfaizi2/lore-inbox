Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966445AbWKNXBb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966445AbWKNXBb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 18:01:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966442AbWKNXBb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 18:01:31 -0500
Received: from main.gmane.org ([80.91.229.2]:25486 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S966445AbWKNXBa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 18:01:30 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: nightly 2.6 LXR run?
Date: Tue, 14 Nov 2006 23:00:34 +0000 (UTC)
Organization: Palacky University in Olomouc, experimental physics department.
Message-ID: <slrnelkj1s.7lr.olecom@flower.upol.cz>
References: <1163530480.16381.23.camel@jcm.boston.redhat.com>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: flower.upol.cz
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>, Oleg Verych <olecom@flower.upol.cz>
User-Agent: slrn/0.9.8.1pl1 (Debian)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo.
On 2006-11-14, Jon Masters wrote:
> Hi folks,
>
> So I'm curious (before I do it) whether anyone is currently running an
> automated nightly LXR against Linus' git kernel tree?

I don't think so. Also, i don't think, it's useful for development.
There are TAGS/tags make targets for it, and they're more productive, i think.

But what really will be helpful (well, for me), is another git-web public 
service on Linus' git tree. kernel.org is very heavy loaded with many
things, so normally i get "The load average on the server is too high",
when trying to trace some code history and reading logs. There were
some lkml posts, even from Linus, stating, that kernel.org is very
loaded and slow.

I don't want to load it much with git pull also, i just need history and
logs. Hope somebody will benefit from it too.

> I know of coywolf's excellent resource, but since I'm playing with LXR
> for some other stuff at the moment it'd be a good moment to get it done.
>
> Jon.
____

