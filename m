Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUFJSbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUFJSbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 14:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbUFJSbv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 14:31:51 -0400
Received: from web14202.mail.yahoo.com ([216.136.172.144]:35076 "HELO
	web14202.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262256AbUFJSbu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 14:31:50 -0400
Message-ID: <20040610183149.59944.qmail@web14202.mail.yahoo.com>
Date: Thu, 10 Jun 2004 11:31:49 -0700 (PDT)
From: "j.random.programmer" <javadesigner@yahoo.com>
Subject: Re: Threading behavior in 2.6.5 may be broken ?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

One last followup:

This problem has gone way in 2.6.6(fedora
2.6.6-1.424).

Whatever change was made between 2.6.5 and 2.6.6
fixed this. In 2.6.6, I can in fact create 10,000
threads and this does not hang the entire machine 
(in 2.6.5, when the machine hung, even the console 
was inoperative and I couldn't run vmstat or cat
/proc/meminfo to see what was going on). 

Best regards,

--j


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
