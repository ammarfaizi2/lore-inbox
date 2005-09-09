Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751424AbVIIHOO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751424AbVIIHOO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 03:14:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751425AbVIIHOO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 03:14:14 -0400
Received: from ns2.suse.de ([195.135.220.15]:45482 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751422AbVIIHON (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 03:14:13 -0400
Date: Fri, 9 Sep 2005 09:14:07 +0200
From: Andi Kleen <ak@suse.de>
To: Jan Beulich <JBeulich@novell.com>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: [discuss] [PATCH] add and handle NMI_VECTOR II
Message-ID: <20050909071407.GI19913@wotan.suse.de>
References: <43207DFC0200007800024543@emea1-mh.id2.novell.com> <20050909004307.GA18347@wotan.suse.de> <43214AE402000078000247AB@emea1-mh.id2.novell.com> <200509090855.52752.ak@suse.de> <4321525102000078000247C2@emea1-mh.id2.novell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4321525102000078000247C2@emea1-mh.id2.novell.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> ??? This is what the code doing the setup does. But the question was -
> what do you need the IDT entry for?

Without an IDT entry you cannot receive it? 

-Andi
