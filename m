Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261711AbUJ1PMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261711AbUJ1PMa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 11:12:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261694AbUJ1PHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 11:07:51 -0400
Received: from holomorphy.com ([207.189.100.168]:8585 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261705AbUJ1PEH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 11:04:07 -0400
Date: Thu, 28 Oct 2004 08:03:29 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "michael@optusnet.com.au" <michael@optusnet.com.au>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'Bill Davidsen'" <davidsen@tmr.com>, Massimo Cetra <mcetra@navynet.it>,
       Ed Tomlinson <edt@aei.ca>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       John Richard Moser <nigelenki@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041028150329.GK12934@holomorphy.com>
References: <200410280907_MC3-1-8D5A-FF57@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200410280907_MC3-1-8D5A-FF57@compuserve.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 at 00:13:44 -0700 William Lee Irwin III wrote:
>> I'd expect vastly less than 1%, starting from the arch count, and then
>> making some conservative guesses about drivers. Drivers probably
>> actually take it down to far, far less than 1%.

On Thu, Oct 28, 2004 at 09:04:41AM -0400, Chuck Ebbert wrote:
>   Sure, but pretty much each installation uses a different 1%.
>   If there's a bug in there it's bound to hit someone; that's
> what makes OS writing so difficult.  (And that's why "It works
> for me" is not really a useful statement about the overall quality
> of an operating system.)

99.99% of users use one arch, i386.
99.99% of users use one disk driver, IDE.
The intersection of these users is probably well over 99.999% of all
users.

Then probably a small list of secondary drivers varies. Statistically,
users with anything but the crappiest x86 s**tboxen and a tiny subset
of all drivers (arjan's 20) are hopelessly outnumbered.


-- wli
