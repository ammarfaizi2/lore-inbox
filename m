Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262802AbUJ1HOT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262802AbUJ1HOT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:14:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262815AbUJ1HOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:14:19 -0400
Received: from holomorphy.com ([207.189.100.168]:43141 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262802AbUJ1HOL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:14:11 -0400
Date: Thu, 28 Oct 2004 00:13:44 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: michael@optusnet.com.au
Cc: John Richard Moser <nigelenki@comcast.net>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       Ed Tomlinson <edt@aei.ca>, Massimo Cetra <mcetra@navynet.it>,
       "'Chuck Ebbert'" <76306.1226@compuserve.com>,
       "'Bill Davidsen'" <davidsen@tmr.com>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>
Subject: Re: My thoughts on the "new development model"
Message-ID: <20041028071344.GJ12934@holomorphy.com>
References: <00c201c4bb4c$56d1b8b0$e60a0a0a@guendalin> <200410261719.56474.edt@aei.ca> <Pine.LNX.4.61.0410270402340.20284@student.dei.uc.pt> <417F315A.9060906@comcast.net> <m1sm7znxul.fsf@mo.optusnet.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <m1sm7znxul.fsf@mo.optusnet.com.au>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 28, 2004 at 04:46:58PM +1000, michael@optusnet.com.au wrote:
> That's NOT the same as bug free software. For a start, there's no such
> thing. For another, many bugs are perfectly acceptable in a production
> environment as long as they're not impacting. (The linux kernel is a
> very large piece of work. Few installations would use even 20% of the
> total kernel functionality).

I'd expect vastly less than 1%, starting from the arch count, and then
making some conservative guesses about drivers. Drivers probably
actually take it down to far, far less than 1%.


-- wli
