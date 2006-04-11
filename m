Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751273AbWDKTwL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751273AbWDKTwL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Apr 2006 15:52:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbWDKTwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Apr 2006 15:52:10 -0400
Received: from smtprelay01.ispgateway.de ([80.67.18.13]:63448 "EHLO
	smtprelay01.ispgateway.de") by vger.kernel.org with ESMTP
	id S1751272AbWDKTwK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Apr 2006 15:52:10 -0400
From: Ingo Oeser <ioe-lkml@rameria.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] de_thread: Don't confuse users do_each_thread.
Date: Tue, 11 Apr 2006 21:50:06 +0200
User-Agent: KMail/1.9.1
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20060406220403.GA205@oleg> <200604110925.08685.ioe-lkml@rameria.de> <m11ww4d0nm.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m11ww4d0nm.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200604112150.07493.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 11. April 2006 09:36, Eric W. Biederman wrote:
[cleanup of current usage]
> Please skip de_thread.  I will catch that one, in a minute.  There is
> enough churn on that function that you are likely to patch the wrong
> version.

Ok, I'll wait for you and Oleg. Maybe I should revisit this cleanup
after 2.6.18 opens up. If you both are done in that area, just tell me
and I'll cook up a patch.

Regards

Ingo Oeser
