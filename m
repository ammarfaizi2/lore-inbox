Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269448AbUJFV5b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269448AbUJFV5b (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 17:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269484AbUJFVyu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 17:54:50 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:59054 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269475AbUJFVqj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 17:46:39 -0400
Message-ID: <416467B2.4080107@us.ibm.com>
Date: Wed, 06 Oct 2004 14:46:26 -0700
From: Ian Romanick <idr@us.ibm.com>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: dri-devel@lists.sourceforge.net, lkml <linux-kernel@vger.kernel.org>
Subject: Re: Code status (Was: New DRM driver model - gets rid of DRM() macros!)
References: <9e4733910409280854651581e2@mail.gmail.com> <20040929235238.46c55c58.felix@trabant> <9e4733910409291625281e278b@mail.gmail.com> <20041006133714.GA26860@localdomain> <9e47339104100609307307f8ea@mail.gmail.com> <20041006211922.GA5167@localdomain>
In-Reply-To: <20041006211922.GA5167@localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

José Fonseca wrote:

> They happen one after the other so fast that they're never recorded on
> /proc/kmsg. I got a screenshot (literaly, with a digital camera) on
> http://jrfonseca.dyndns.org/misc/bugs/radeon-core.jpg after insmod'ing
> radeon. It's likely that the first oops is within the loaded module, but
> all the others oops trash it away...

This is funny to me.  I seem to remember someone scoffing the importance 
of being able to print oopses, no matter what, at kernel summit.  A lot 
of people nodded approvingly until Linus took the mic...and described 
almost exactly this situation! :)
