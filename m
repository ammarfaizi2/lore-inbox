Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262364AbULOTDk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262364AbULOTDk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Dec 2004 14:03:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262392AbULOTDk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Dec 2004 14:03:40 -0500
Received: from web51504.mail.yahoo.com ([206.190.38.196]:44657 "HELO
	web51504.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262364AbULOTDV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Dec 2004 14:03:21 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=YAQmBptort5lIZ4Z2PPMcNdSJZngvqDw3zAmgNUnWDkd9IyuQWN6XCyVTRy7374rKppqZYBQK0kPSYCzX0WfzxxPAQ1Sf4JOYNggjstxCPniMvuY/GBvh6EG3HDpZzs9sVzglnHaK5hti1iqUu05aX3ufBV+xcPYTmrdmF5EuSg=  ;
Message-ID: <20041215190314.33997.qmail@web51504.mail.yahoo.com>
Date: Wed, 15 Dec 2004 11:03:14 -0800 (PST)
From: Park Lee <parklee_sel@yahoo.com>
Subject: Re: Issue on connect 2 modems with a single phone line
To: Lee Revell <rlrevell@joe-job.com>
Cc: dave@lafn.org, linux-kernel@vger.kernel.org
In-Reply-To: <1103136506.18982.73.camel@krustophenia.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Dec 2004 at 13:48, Lee Revell wrote:
> On Wed, 2004-12-15 at 10:42 -0800, Park Lee wrote:
> > Hi,
> > I want to try serial console in order to see the
> > complete Linux kernel oops. 
> > I have 2 computers, one is a PC, and the other is 
> > a Laptop. Unfortunately,my Laptop doesn't have a 
> > serial port on it.
>
> No idea but it would be way easier to use 
> netconsole.  That is, unless the oops happens 
> before the network is up.

Yes, I've tried to use netconsole. But it seemed that
it wasn't fit for my case, because the kernel crash
occurs in the net subsection. When kernel doesn't
crash, the netconsole works well. BUT, when the kernel
crashs, the netconsole cann't send out the oops
message!


=====
Best Regards,
Park Lee


		
__________________________________ 
Do you Yahoo!? 
Read only the mail you want - Yahoo! Mail SpamGuard. 
http://promotions.yahoo.com/new_mail 
