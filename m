Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265469AbTBJWXy>; Mon, 10 Feb 2003 17:23:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265446AbTBJWXy>; Mon, 10 Feb 2003 17:23:54 -0500
Received: from e35.co.us.ibm.com ([32.97.110.133]:6293 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S265469AbTBJWXw>;
	Mon, 10 Feb 2003 17:23:52 -0500
Date: Mon, 10 Feb 2003 14:24:39 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Ion Badulescu <ionut@badula.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Testing new starfire driver for 2.5
Message-ID: <544930000.1044915879@flay>
In-Reply-To: <Pine.LNX.4.44.0302101650440.3127-100000@guppy.limebrokerage.com>
References: <Pine.LNX.4.44.0302101650440.3127-100000@guppy.limebrokerage.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I've been using your new starfire driver for a couple of weeks now,
>> and it's in 2.5-mjb ... been testing on the 16x NUMA-Q w/16Gb RAM.
>> 
>> Not only does it work just fine with no problems, all the wierd error
>> messages I had before went away ;-)
> 
> Good to hear that...
> 
> Which version did you end up using: 1.4.0 or 1.3.9?

1.4.0
 
>> Seems cool to me, are you ready to push this to Linus?
> 
> Well, 1.3.9 is already in Marcelo's tree. I'll push 1.4.1 -- which is 
> 1.4.0 plus a compile option for enabling/disabling NAPI -- to Linus as 
> soon as I finish testing with both compile options.

Sounds good to me! Thanks for fixing all this,

M.

