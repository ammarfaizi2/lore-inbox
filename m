Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751369AbWGWWGC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751369AbWGWWGC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Jul 2006 18:06:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751363AbWGWWGB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Jul 2006 18:06:01 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:32162 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S1751325AbWGWWGA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Jul 2006 18:06:00 -0400
Message-ID: <44C3F2C6.5010001@garzik.org>
Date: Sun, 23 Jul 2006 18:05:58 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev List <netdev@vger.kernel.org>
Subject: Private driver support emails should be avoided.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a reminder to folks out there...  Don't send private driver support 
emails.

I receive a lot of email.  A lot.  Not as much as Linus or Andrew 
probably, but still sizable.  And quite regularly, I will receive a 
private email asking for help on a SATA or net driver problem.  The 
poster will include various details on their problem, and ask for help 
debugging the problem.  While the email will indeed be skimmed -- 
looking at a mass of bug reports, one can better detect patterns -- the 
people seeking support privately will almost NEVER RECEIVE A RESPONSE.

Unless there is a security issue (email security@kernel.org), posters 
should ALWAYS email their report(s) to one or more mailing lists.

Private email
* is not archived publicly
* is not Google-able
* restricts the sharing of knowledge
* prevents other users from responding to your email

Feel free to CC me on problems you think should warrant my attention.  A 
carbon copy is acceptable to almost all regular kernel contributors.


As another tip, if a kernel bug or annoyance persists, people are 
encouraged to maintain wiki and web pages describing the behavior, and 
discussed problem history.  Maintaining "SATA sucks on ThinkPad" style 
web pages is always a good way to shame kernel hackers into action ;-) 
Maintaining such web pages is a good way for a group of affected users 
to pool common information, and suggested workarounds.

Ensuring the freshness of bugzilla.kernel.org information is also a 
great way for non-kernel hackers to help out.  Sometimes a bug is only 
solved after a pattern emerges from a group of problem reports.  Even 
"me too!" bugzilla reports are helpful...  if they are followed by 
highly detailed hardware and kernel information.

	Jeff



