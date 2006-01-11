Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932797AbWAKGiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932797AbWAKGiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 01:38:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932798AbWAKGiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 01:38:55 -0500
Received: from mail.dvmed.net ([216.237.124.58]:15825 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932797AbWAKGiy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 01:38:54 -0500
Message-ID: <43C4A7EA.9050402@pobox.com>
Date: Wed, 11 Jan 2006 01:38:34 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Coywolf Qi Hunt <qiyong@fc-cn.com>
CC: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: why no -mm git tree?
References: <20060111055616.GA5976@localhost.localdomain>
In-Reply-To: <20060111055616.GA5976@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Coywolf Qi Hunt wrote: > hello, > > Why don't use a -mm
	git tree? Maybe it was time for it. > With a -mm git tree, we can help
	-mm test much earlier and quicker, A -mm git tree would be nice. > and
	no more need of the mm-commits ML. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Coywolf Qi Hunt wrote:
> hello,
> 
> Why don't use a -mm git tree? Maybe it was time for it.
> With a -mm git tree, we can help -mm test much earlier and quicker,

A -mm git tree would be nice.


> and no more need of the mm-commits ML.

Strongly disagree.


> Also an option, to use git, and still gernerate broken-out from git.

AFAICT from akpm's workflow, it would be far easier to generate a git 
tree from his pile of patches, than the other way around.

	Jeff


