Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264085AbUESG41@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264085AbUESG41 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 May 2004 02:56:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUESG41
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 May 2004 02:56:27 -0400
Received: from web50205.mail.yahoo.com ([206.190.38.46]:62623 "HELO
	web50205.mail.yahoo.com") by vger.kernel.org with SMTP
	id S264085AbUESG4X (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 May 2004 02:56:23 -0400
Message-ID: <20040519065623.30802.qmail@web50205.mail.yahoo.com>
Date: Tue, 18 May 2004 23:56:23 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: Re: signal handling issue.
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Use siglonjmp() and sigsetjmp().  You are not allowed to use longjmp()
>to jump from a signal handler.

Is this documented anywhere??

=====
I code, therefore I am


	
		
__________________________________
Do you Yahoo!?
SBC Yahoo! - Internet access at a great low price.
http://promo.yahoo.com/sbc/
