Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263423AbUKZTuq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbUKZTuq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Nov 2004 14:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263543AbUKZTuo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Nov 2004 14:50:44 -0500
Received: from zeus.kernel.org ([204.152.189.113]:62401 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S262360AbUKZT0R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Nov 2004 14:26:17 -0500
Date: Fri, 26 Nov 2004 06:35:32 -0700 (MST)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
cc: Sumit Pandya <sumit@elitecore.com>, linux-kernel@vger.kernel.org,
       len.brown@intel.com
Subject: Re: OOPS - APIC or othere?
In-Reply-To: <20041126064200.GB4912@logos.cnet>
Message-ID: <Pine.LNX.4.61.0411260634280.23651@montezuma.fsmlabs.com>
References: <Pine.LNX.4.61.0411170941130.3941@musoma.fsmlabs.com>
 <HGEFKOBCHAIJDIEJLAKDAEMKCAAA.sumit@elitecore.com> <20041126064200.GB4912@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 Nov 2004, Marcelo Tosatti wrote:

> On Fri, Nov 26, 2004 at 02:23:57PM +0530, Sumit Pandya wrote:
> > Marcelo,
> > 	No other message except my name "Sumit" ? 
> 
> Yes, because Zwane has written the message
> 
> "Sending bug report for partially patched kernel isn't easy for us to 
> debug, is there no way for you to simply try booting 2.4.27?"
> 
> And I was assuming you read that. Did you?
> 
> The bugzilla entry makes it understand that Len has fixed the 
> problem in 2.4.27:
> 
> Seems to be doing its job then isnt it?

I agree with Marcelo, it looks like a fairly isolated change, if you can 
get by with applying only that patch then you'll be fine.

Thanks,
	Zwane

