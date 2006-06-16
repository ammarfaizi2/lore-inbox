Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751166AbWFPJWm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751166AbWFPJWm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 05:22:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751043AbWFPJWm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 05:22:42 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8083 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750839AbWFPJWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 05:22:41 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Daniel Lezcano <dlezcano@fr.ibm.com>
Cc: serue@us.ibm.com, haveblue@us.ibm.com, clg@fr.ibm.com,
       linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [RFC] [patch 0/6] [Network namespace] introduction
References: <20060609210202.215291000@localhost.localdomain>
	<m1mzcdpw3i.fsf@ebiederm.dsl.xmission.com>
	<449274A3.5050304@fr.ibm.com>
Date: Fri, 16 Jun 2006 03:22:15 -0600
In-Reply-To: <449274A3.5050304@fr.ibm.com> (Daniel Lezcano's message of "Fri,
	16 Jun 2006 11:06:43 +0200")
Message-ID: <m1zmgdo3p4.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Lezcano <dlezcano@fr.ibm.com> writes:

> Eric W. Biederman wrote:
>
>  > Have you seen my previous work in this direction?
>> I know I had a much much more complete implementation.  The only part
>> I had not completed was iptables support and that was about a days
>> more work.
>
> No, I didn't see your work, is it possible to send me a pointer on it or to have
> a patchset of your code ?

It is in my git tree up on kernel.org.  I think it is in my proof-of-concept
branch.

The individual commits tell a tangled tale that is definitely unacceptable
for an upstream merge but the actual result is interesting.

If that isn't enough to find it, tell me and I will track down the details.
It has been a couple months since I posted it during the design discussion
and I'm way overdue for being in bed, tonight.

Eric



