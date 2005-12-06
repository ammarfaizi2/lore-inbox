Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932614AbVLMTtr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932614AbVLMTtr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Dec 2005 14:49:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932603AbVLMTtb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Dec 2005 14:49:31 -0500
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:63309 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932597AbVLMTtV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Dec 2005 14:49:21 -0500
Message-ID: <4395F8B4.6000208@tmr.com>
Date: Tue, 06 Dec 2005 15:46:44 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lars Marowsky-Bree <lmb@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de> <43949541.9060700@tmr.com> <20051206132559.GV21914@marowsky-bree.de>
In-Reply-To: <20051206132559.GV21914@marowsky-bree.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lars Marowsky-Bree wrote:
> On 2005-12-05T14:30:09, Bill Davidsen <davidsen@tmr.com> wrote:
> 
> 
>>Actually I would be happy with the stability of this series if people 
>>would stop trying to take working features OUT of it!
> 
> 
> Features are removed when they are no longer features, but design
> irritations in a new and improved design, and usually, equivalent or
> better (or at least thought to be) functionality is available still in
> the big picture (which includes user-space), hopefully in a cleaner
> place.
> 
> Now, design is often a holy war, and people disagree. That's fine and to
> be expected. And sometimes, the whole solution takes a while to
> materialize and be implemented from the kernel up to all user-space and
> even longer until it has been implemented in the brains of the admins.
> This, too, is fine and expected. It's called "innovation" and
> "development", sometimes iterative.

Removing features because there are better solutions is one thing, 
although it has been done at kernel tree changes for a decade. Removing 
features for reasons of religion is rather a case of developers removing 
a useful and unbroken feature for which there is no replacement purely 
because someone doesn't like it, or it saves a dozen lines of code.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me

