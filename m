Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVBZVrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVBZVrt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Feb 2005 16:47:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261249AbVBZVrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Feb 2005 16:47:49 -0500
Received: from web51904.mail.yahoo.com ([206.190.39.47]:30324 "HELO
	web51904.mail.yahoo.com") by vger.kernel.org with SMTP
	id S261246AbVBZVrs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Feb 2005 16:47:48 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=LIUINJWdLHPw1BDpjFG/lNpf7gmuGMONKs/UVXX2Q4K661uNrTk5yW96d7J2EwwjpQTPGRUC7tPyfziknNvkaSb28DyGZvsZ9lGKlsogMzNg/pdMg8Fq3QlIdEp6A2rQFQYuk9OcP4+AvHW28IQRRSlVelMYRZ+bLwiFVxXWl0g=  ;
Message-ID: <20050226214743.64018.qmail@web51904.mail.yahoo.com>
Date: Sat, 26 Feb 2005 13:47:43 -0800 (PST)
From: Melkor Ainur <melkorainur@yahoo.com>
Subject: userspace app needing signal on parport input change
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Is there a way for a user space app to get a signal or
maybe woken up from select/read when there is a change
on a particular input pin on the parallel port?

Thanks.


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
