Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263055AbUJ1NIs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263055AbUJ1NIs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 09:08:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263054AbUJ1NIs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 09:08:48 -0400
Received: from siaag1aa.compuserve.com ([149.174.40.3]:64477 "EHLO
	siaag1aa.compuserve.com") by vger.kernel.org with ESMTP
	id S263051AbUJ1NIg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 09:08:36 -0400
Date: Thu, 28 Oct 2004 09:04:41 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: My thoughts on the "new development model"
To: William Lee Irwin III <wli@holomorphy.com>
Cc: "michael@optusnet.com.au" <michael@optusnet.com.au>,
       "'linux-kernel'" <linux-kernel@vger.kernel.org>,
       "'Bill Davidsen'" <davidsen@tmr.com>, Massimo Cetra <mcetra@navynet.it>,
       Ed Tomlinson <edt@aei.ca>,
       "Marcos D. Marado Torres" <marado@student.dei.uc.pt>,
       John Richard Moser <nigelenki@comcast.net>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-ID: <200410280907_MC3-1-8D5A-FF57@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Oct 2004 at 00:13:44 -0700 William Lee Irwin III wrote:
> On Thu, Oct 28, 2004 at 04:46:58PM +1000, michael@optusnet.com.au wrote:
>> [...] many bugs are perfectly acceptable in a production
>> environment as long as they're not impacting. (The linux kernel is a
>> very large piece of work. Few installations would use even 20% of the
>> total kernel functionality).
>
> I'd expect vastly less than 1%, starting from the arch count, and then
> making some conservative guesses about drivers. Drivers probably
> actually take it down to far, far less than 1%.


  Sure, but pretty much each installation uses a different 1%.

  If there's a bug in there it's bound to hit someone; that's
what makes OS writing so difficult.  (And that's why "It works
for me" is not really a useful statement about the overall quality
of an operating system.)


--Chuck Ebbert  28-Oct-04  09:00:36
