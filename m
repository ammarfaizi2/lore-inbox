Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261365AbVBNXgx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261365AbVBNXgx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:36:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261334AbVBNXgw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:36:52 -0500
Received: from mx1.redhat.com ([66.187.233.31]:42939 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261348AbVBNXfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:35:16 -0500
Date: Mon, 14 Feb 2005 18:35:06 -0500 (EST)
From: Rik van Riel <riel@redhat.com>
X-X-Sender: riel@chimarrao.boston.redhat.com
To: Kurt Garloff <garloff@suse.de>
cc: Linux kernel list <linux-kernel@vger.kernel.org>,
       Andreas Gruenbacher <agruen@suse.de>, James Morris <jmorris@redhat.com>,
       Chris Wright <chrisw@osdl.org>
Subject: Re: [PATCH] 4/5: LSM hooks rework
In-Reply-To: <20050214232757.GJ18744@tpkurt.garloff.de>
Message-ID: <Pine.LNX.4.61.0502141834350.14001@chimarrao.boston.redhat.com>
References: <20050213210515.GH27893@tpkurt.garloff.de>
 <20050213211034.GI27893@tpkurt.garloff.de> <20050213211109.GJ27893@tpkurt.garloff.de>
 <20050213211139.GK27893@tpkurt.garloff.de> <20050213211210.GL27893@tpkurt.garloff.de>
 <Pine.LNX.4.61.0502141152560.14001@chimarrao.boston.redhat.com>
 <20050214232757.GJ18744@tpkurt.garloff.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Feb 2005, Kurt Garloff wrote:

> I sent out the full patch set, which moves the code from
> vanilla to the code we've been shipping since 7 months.

Heh, it sounds like such a step back when it's said like that ;)

> If we can't find consensus for patches 4 and 5, I'd still
> think applying 1 -- 3 is useful.

I'll take a look at the other patches.

-- 
"Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it." - Brian W. Kernighan
