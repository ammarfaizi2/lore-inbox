Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264138AbTDWQvE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Apr 2003 12:51:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264139AbTDWQvE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Apr 2003 12:51:04 -0400
Received: from nessie.weebeastie.net ([61.8.7.205]:19331 "EHLO
	nessie.weebeastie.net") by vger.kernel.org with ESMTP
	id S264138AbTDWQvB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Apr 2003 12:51:01 -0400
Date: Thu, 24 Apr 2003 03:03:36 +1000
From: CaT <cat@zip.com.au>
To: Stuffed Crust <pizza@shaftnet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [2.5.68] [BUG #18] Add Synaptics touchpad tweaking to psmouse driver
Message-ID: <20030423170336.GL1202@zip.com.au>
References: <20030422024628.GA8906@shaftnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030422024628.GA8906@shaftnet.org>
User-Agent: Mutt/1.3.28i
Organisation: Furball Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 21, 2003 at 10:46:28PM -0400, Stuffed Crust wrote:
> One of the side-effects of the new input layer is that the old usermode 
> tools for manipulating the touchpad configuration don't work any more.

Aye. :/

> Most importantly, the ability to disable the tap-to-click "feature".
> And this has been long-recognized, as bug #18.  :)

Bah. I like this and use it often. :)

> Feedback welcome!

I haven't tested it mainly because it doesn't do anything useful for me
yet (and, infact, reduces usability) but I'll be more then happy to test
any future more general patches that you may come up with.

-- 
Martin's distress was in contrast to the bitter satisfaction of some
of his fellow marines as they surveyed the scene. "The Iraqis are sick
people and we are the chemotherapy," said Corporal Ryan Dupre. "I am
starting to hate this country. Wait till I get hold of a friggin' Iraqi.
No, I won't get hold of one. I'll just kill him."
	- http://www.informationclearinghouse.info/article2479.htm
