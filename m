Return-Path: <linux-kernel-owner+w=401wt.eu-S1751765AbXAOAns@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751765AbXAOAns (ORCPT <rfc822;w@1wt.eu>);
	Sun, 14 Jan 2007 19:43:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751767AbXAOAns
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Jan 2007 19:43:48 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:58056 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751765AbXAOAnr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Jan 2007 19:43:47 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Mon, 15 Jan 2007 01:43:23 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: [RFC] How to (automatically) find the correct maintainer(s)
To: Matthias Schniedermeyer <ms@citd.de>
cc: Richard Knutsson <ricknu-0@student.ltu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <45AAC44D.808@citd.de>
Message-ID: <tkrat.0ce30797d3555dc3@s5r6.in-berlin.de>
References: <45A9092F.7060503@student.ltu.se> <45A93B02.7040301@citd.de>
 <45A96E31.3080307@student.ltu.se> <45A973A8.1000101@citd.de>
 <45AAA3C2.80603@student.ltu.se> <tkrat.b40f8fe0936d84cd@s5r6.in-berlin.de>
 <45AAC44D.808@citd.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 15 Jan, Matthias Schniedermeyer wrote:
> Stefan Richter wrote:
>> On 14 Jan, Richard Knutsson wrote:
>>>(Really liked the idea to have a "Maintainer"-button 
>>>next to "Help" in *config)
>> 
>> Rhetorical question: What will this button be used for?
> 
> Having "all(tm)" information of something in one place?

Or, "click here to say 'it does not work'"?

My rhetorical question wasn't about what it is intended for, but what
people would think it was intended for if it was there.

> Help-Text and Dependencies/Selects are already there.

Yes. For the purpose of configuring the kernel.

> I think adding the Maintainers-data is more or less a logical next step.
> 
> It's not always clear from the MAINTAINERS-file who is the right person
> for what. Especially as it is a rather large text-file with only
> mediocre search-friendlieness. It's a 3.5 K-lines file!
> 
> So when you know that you have a problem with drivers X, wouldn't it be
> great if you could just "go to" the driver in *config and see not only
> the Help-Text but the Maintainers-Data also.

Seems more like what you actually want to have there is links to users'
mailinglists or forums.

When this thread started, it was about assisting authors in submitting
patches.

> And you can place "Fallback"-Maintainers-Data on Tree-Parents, for the
> cases where you only can pinpoint a area, like when you have a problem
> with a USB-device.
> 
> 
> I can ask a rhetorical question too:
> Why not go back to Config.help. Having a huge X K-Lines file with
> everything in one file can't be that bad. It worked before!

I am in no way against Richard's plan to improve development and
maintenance processes by easier access to contact data.
-- 
Stefan Richter
-=====-=-=== ---= -====
http://arcgraph.de/sr/

