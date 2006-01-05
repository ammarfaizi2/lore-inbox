Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751468AbWAEQ2O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751468AbWAEQ2O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 11:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751470AbWAEQ2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 11:28:14 -0500
Received: from dpc6682004040.direcpc.com ([66.82.4.40]:31767 "EHLO
	a34-mta02.direcway.com") by vger.kernel.org with ESMTP
	id S1751468AbWAEQ2N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 11:28:13 -0500
Date: Thu, 05 Jan 2006 10:54:52 -0500
From: Ben Collins <ben.collins@ubuntu.com>
Subject: Re: [PATCH 0/15] Ubuntu patch sync
In-reply-to: <1136476010.4158.196.camel@pmac.infradead.org>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Stephen Hemminger <shemminger@osdl.org>, linux-kernel@vger.kernel.org
Message-id: <1136476493.4430.93.camel@grayson>
Organization: Ubuntu Linux
MIME-version: 1.0
X-Mailer: Evolution 2.5.3
Content-type: text/plain
Content-transfer-encoding: 7BIT
References: <0ISL003P992UCY@a34-mta01.direcway.com>
 <20060104140627.1e89c185@dxpl.pdx.osdl.net> <1136412768.4430.28.camel@grayson>
 <20060104143023.5b2f7967@dxpl.pdx.osdl.net> <1136414740.4430.44.camel@grayson>
 <1136476010.4158.196.camel@pmac.infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-05 at 15:46 +0000, David Woodhouse wrote:
> On Wed, 2006-01-04 at 17:45 -0500, Ben Collins wrote:
> > After dealing with literally dozens of upstream drivers, I think the
> > reasons boil down to a few categories:
> 
> > <...>
> 
> You missed one:
> 
> 5 - They've implemented Yet Another IEEE802.11 stack instead of
> embracing and extending the Intel one we already have, and are hence
> urinating into the atmospheric disturbance.
> 
> That's one of the reasons why I merged bcm43xx and softmac into the
> Fedora kernel and none of the others, FWIW -- Johannes is actually
> working on improving what we have in the kernel, rather than just saying
> "You have to throw it all away because $MYSTACK is better". So I figure
> softmac has a _much_ better chance of going upstream, even if its
> feature list isn't quite as comprehensive yet.

Yeah, I did the same for bcm43xx (it's in the ubuntu tree, and working
on my powerbook right now with wep :)

Didn't notice softmac had a git tree now. And here I am pulling from
mercurial and hand merging :/

> http://softmac.sipsolutions.net/softmac-2.6.git

-- 
   Ben Collins <ben.collins@ubuntu.com>
   Developer
   Ubuntu Linux

