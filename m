Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbUKCWK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbUKCWK0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 17:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261915AbUKCWFx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 17:05:53 -0500
Received: from out003pub.verizon.net ([206.46.170.103]:5321 "EHLO
	out003.verizon.net") by vger.kernel.org with ESMTP id S261908AbUKCWED
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 17:04:03 -0500
Message-ID: <418955D2.7000700@verizon.net>
Date: Wed, 03 Nov 2004 17:04:02 -0500
From: Jim Nelson <james4765@verizon.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
CC: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH 5/5] documentation: Remove drivers/char/README.cycladesZ
References: <20041103152246.24869.2759.68945@localhost.localdomain> <20041103152314.24869.56459.88722@localhost.localdomain> <20041103133103.GB4109@logos.cnet> <41891AF3.9050800@verizon.net> <20041103150947.GA4695@logos.cnet>
In-Reply-To: <20041103150947.GA4695@logos.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Authentication-Info: Submitted using SMTP AUTH at out003.verizon.net from [68.238.31.6] at Wed, 3 Nov 2004 16:04:02 -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:
> On Wed, Nov 03, 2004 at 12:52:51PM -0500, Jim Nelson wrote:
> 
>>You're right.  I'll send a patch to put README.cycladesZ in 
>>Documentation/serial right now.
> 
> 
> Also please only remove other README's if they are really obsolete. 
> Whats your criteria for choosing what is obsolete?
> 

I erred on README.cycladesZ, I'll admit.  My apologies.  I normally contact the 
maintainer *before* making a call like that.  Well, I'm kinda new to this, and 
making mistakes is part of the process.

My unofficial "guidelines" for what needs to be looked at more closely include: 
references to 2.0, 2.1, 2.2, 2.3, or 2.5 kernels, references to external modules, 
dates of 2002 or earlier, or just a "wait a minute, I don't think that's right". 
Not the prettiest technique, I know.

> Move the rest to Documentation/serial, fine.
> 

