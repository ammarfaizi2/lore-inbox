Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbVB1WRL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVB1WRL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Feb 2005 17:17:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261783AbVB1WRL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Feb 2005 17:17:11 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:51423 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261780AbVB1WRJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Feb 2005 17:17:09 -0500
Message-ID: <4223998A.2090302@tmr.com>
Date: Mon, 28 Feb 2005 17:22:02 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: shabanip <shabanip@avapajoohesh.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel 2.6 hyperthreading 
References: <52679.69.93.110.242.1109288060.squirrel@69.93.110.242>
In-Reply-To: <52679.69.93.110.242.1109288060.squirrel@69.93.110.242>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

shabanip wrote:
> enabling hyperthreading on kernel 2.6 how much affects the performance?

Typically 10-30% depending on what you are doing. For some rare loads it 
could actually hurt a few percent, although I haven't personally ever 
seen that.

It seems to make the desktop feel smoother, but I have no way to 
quantify that.

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
