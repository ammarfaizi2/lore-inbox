Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264321AbRFHUev>; Fri, 8 Jun 2001 16:34:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264322AbRFHUel>; Fri, 8 Jun 2001 16:34:41 -0400
Received: from age.cs.columbia.edu ([128.59.22.100]:12048 "EHLO
	age.cs.columbia.edu") by vger.kernel.org with ESMTP
	id <S264321AbRFHUe0>; Fri, 8 Jun 2001 16:34:26 -0400
Date: Fri, 8 Jun 2001 13:34:15 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Tom Sightler <ttsig@tuxyturvy.com>
cc: <linux-kernel@vger.kernel.org>, <arjan@fenrus.demon.nl>
Subject: Re: xircom_cb problems
In-Reply-To: <992009463.3b20dcf7467ab@eargle.com>
Message-ID: <Pine.LNX.4.33.0106081333090.1029-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Tom Sightler wrote:

> OK, I tried your patch, it did fix the problem where pump wouldn't
> pull an IP address, but I'm still having the problem where my ping
> times go nuts.  I've attached an example, it's 100% repeatable on my
> network at work.  It was so bad I couldn't get any benchmark numbers.

Just one more question: do you see the same bad ping times if you
completely comment out the call to set_half_duplex?

Thanks,
Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

