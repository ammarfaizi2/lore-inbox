Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261627AbTINVhD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 17:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261630AbTINVhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 17:37:03 -0400
Received: from 67-50-116-12.br1.fod.ia.frontiernet.net ([67.50.116.12]:19840
	"EHLO www.duskglow.com") by vger.kernel.org with ESMTP
	id S261627AbTINVhB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 17:37:01 -0400
Date: Sun, 14 Sep 2003 16:41:32 -0500
From: Russell Miller <rmiller@duskglow.com>
To: Dave Jones <davej@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [SUMMARY] rebooting problem solved - athlon/SiS incompatibility.
Message-ID: <20030914214132.GA1833@www.duskglow.com>
References: <20030914205429.GA3535@www.duskglow.com> <20030914210429.GA26027@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030914210429.GA26027@redhat.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 10:04:29PM +0100, Dave Jones wrote:

...

Note the words "an athlon thunderbird processor".  The documentation says, as
I remember, that turning on SMP on a UP board should have no appreciable effect.

I take that back, it says it should run on many, but not all, uniprocessor machines.
So instead of what I said, please note that the K7SEM is a motherboard that will not
work with an SMP kernel.

--Russell

> 		Dave
> 
> -- 
>  Dave Jones     http://www.codemonkey.org.uk
