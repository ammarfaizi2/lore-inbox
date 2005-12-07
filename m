Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbVLGWbs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbVLGWbs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 17:31:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751801AbVLGWbs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 17:31:48 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:41346 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751800AbVLGWbr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 17:31:47 -0500
Subject: Re: [RFC] [PATCH 00/13] Introduce task_pid api
From: Dave Hansen <haveblue@us.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: "SERGE E. HALLYN [imap]" <serue@us.ibm.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Hubertus Franke <frankeh@watson.ibm.com>, Paul Jackson <pj@sgi.com>
In-Reply-To: <m18xuwd015.fsf@ebiederm.dsl.xmission.com>
References: <20051114212341.724084000@sergelap>
	 <m1slt5c6d8.fsf@ebiederm.dsl.xmission.com>
	 <1133977623.24344.31.camel@localhost>
	 <m1hd9kd89y.fsf@ebiederm.dsl.xmission.com>
	 <1133991650.30387.17.camel@localhost>
	 <m18xuwd015.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Wed, 07 Dec 2005 14:31:25 -0800
Message-Id: <1133994685.30387.47.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-12-07 at 15:17 -0700, Eric W. Biederman wrote:
> But beyond that a general test to see if you have done a good
> job of virtualizing something is to see if you can recurse.

I admit it would be interesting at the very least.  But, using that
definition, we haven't done any good virtualization in Linux that I can
think of.  Besides some vague ranting I heard about zSeries (the real
IBM mainframes) I can't think of anything that does this today.

I don think any of Solaris containers, ppc64 LPARs, Xen, UML, or
vservers can recurse.  

Can you think of any?

-- Dave

