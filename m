Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbTDKXbw (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 19:31:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262622AbTDKXb0 (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 19:31:26 -0400
Received: from siaag1ab.compuserve.com ([149.174.40.4]:51933 "EHLO
	siaag1ab.compuserve.com") by vger.kernel.org with ESMTP
	id S262675AbTDKXaC (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 11 Apr 2003 19:30:02 -0400
Date: Fri, 11 Apr 2003 19:38:45 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: kernel support for non-English user messages
To: Matti Aarnio <matti.aarnio@zmailer.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304111941_MC3-1-340E-B808@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> > %s: went up in flames\n\0eth0\0\0
>> 
>>   Is that "\n" an actual ASCII newline or the printk escape sequence?
>
>The backslash is not "printk escape".  It is C-string compilation 
>notation.


  Oops, I guess I was mixing up which layer does what.


--
 "Let's fight till six, and then have dinner," said Tweedledum.
  --Lewis Carroll, _Through the Looking Glass_
