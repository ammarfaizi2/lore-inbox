Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbWIUKYb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbWIUKYb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 06:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750756AbWIUKYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 06:24:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:28385 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1750735AbWIUKYa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 06:24:30 -0400
Date: Thu, 21 Sep 2006 12:24:12 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: john stultz <johnstul@us.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19 -mm merge plans (NTP changes)
In-Reply-To: <1158805731.8648.54.camel@localhost>
Message-ID: <Pine.LNX.4.64.0609211217190.6761@scrub.home>
References: <20060920135438.d7dd362b.akpm@osdl.org> <1158805731.8648.54.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 20 Sep 2006, john stultz wrote:

> No objections here, but I wanted to put forth some caution as I've seen
> some odd NTP behavior with the full NTP patchset on my laptop (either it
> does not converge or it just converges *much* more slowly then without).
> Unfortunately I've not been able to collect solid enough data to analyze
> the issue (really, each run should go for atleast a full day and always
> run on the same network).

grumble...
As I said before it's expected that the initial covergence is slower and I 
need the data over multiple days to really say something about it.
There has been really a lot of time for doing this...

bye, Roman
